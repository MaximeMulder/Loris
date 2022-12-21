import * as R from 'ramda';
import {ofType} from 'redux-observable';
import {Observable, from, of} from 'rxjs';
import * as Rx from 'rxjs/operators';
import {createAction} from 'redux-actions';
import {State as DatasetState} from '../state/dataset';
import {Filter} from '../state/filters';
import {Channel, Chunk} from '../types';
import {State as BoundsState} from '../state/bounds';
import {fetchChunk} from '../../../chunks';
import {MAX_VIEWED_CHUNKS} from '../../../vector';
import {setChannels} from '../state/channels';

export const UPDATE_VIEWED_CHUNKS = 'UPDATE_VIEWED_CHUNKS';
export const updateViewedChunks = createAction(UPDATE_VIEWED_CHUNKS);

type FetchedChunks = {
  channelIndex: number,
  traceIndex: number,
  chunks: Chunk[]
};

/**
 * loadChunks
 *
 * @param {FetchedChunks[]} chunksData - The fetched chunks
 * @returns {Function} - Dispatch actions to the store
 */
export const loadChunks = (chunksData: FetchedChunks[]) => {
  return (dispatch: (_: any) => void) => {
    const channels : Channel[] = [];

    const filters: Filter[] = window.EEGLabSeriesProviderStore
                              .getState().filters;
    for (let index = 0; index < chunksData.length; index++) {
      const {channelIndex, chunks} : {
        channelIndex: number,
        chunks: Chunk[]
      } = chunksData[index];
      for (let i = 0; i < chunks.length; i++) {
        chunks[i].filters = [];
        chunks[i].values = Object.values(filters).reduce(
          (signal: number[], filter: Filter) => {
            chunks[i].filters.push(filter.name);
            return filter.fn(signal);
          },
          chunks[i].originalValues
        );
      }

      const idx = channels.findIndex((c) => c.index === channelIndex);
      if (idx >= 0) {
        channels[idx].traces.push({
          chunks: chunks,
          type: 'line',
        });
      } else {
        channels.push({
          index: channelIndex,
          traces: [{
            chunks: chunks,
            type: 'line',
          }],
        });
      }
    }

    channels.sort((a, b) => a.index - b.index);
    dispatch(setChannels(channels));
  };
};

export const fetchChunkAt = R.memoizeWith(
  (baseURL, downsampling, channelIndex, traceIndex, chunkIndex) =>
    `${baseURL}-${channelIndex}-${traceIndex}-${chunkIndex}-${downsampling}`,
  (
    baseURL: string,
    downsampling: number,
    channelIndex: number,
    traceIndex: number,
    chunkIndex: number
  ) => fetchChunk(
    `${baseURL}/raw/${downsampling}/${channelIndex}/`
     + `${traceIndex}/${chunkIndex}.buf`
  )
);

type State = {bounds: BoundsState, dataset: DatasetState, channels: Channel[]};

const UPDATE_DEBOUNCE_TIME = 100;

/**
 * createFetchChunksEpic
 *
 * @param {Function} fromState - A function to parse the current state
 * @returns {Observable} - An observable
 */
export const createFetchChunksEpic = (fromState: (any) => State) => (
  action$: Observable<any>,
  state$: Observable<any>
) => {
  return action$.pipe(
    ofType(UPDATE_VIEWED_CHUNKS),
    Rx.withLatestFrom(state$),
    Rx.map(([, state]) => fromState(state)),
    Rx.debounceTime(UPDATE_DEBOUNCE_TIME),
    Rx.concatMap(({bounds, dataset, channels}) => {
      const {chunksURL, shapes, timeInterval} = dataset;
      if (!chunksURL) {
        return of();
      }

      const fetches = R.flatten(
        channels.map((channel) => {
          return (
            channel &&
            channel.traces.map((_, j) => {
              const ncs = shapes.map((shape) => shape[shape.length - 2]);

              const citvs = ncs
                .map((nc, downsampling) => {
                  const timeLength = Math.abs(
                    timeInterval[1] - timeInterval[0]
                  );
                  const i0 =
                    (nc * Math.ceil(bounds.interval[0] - bounds.domain[0])) /
                    timeLength;
                  const i1 =
                    (nc * Math.ceil(bounds.interval[1] - bounds.domain[0])) /
                    timeLength;
                  return {
                    interval: [Math.floor(i0), Math.min(Math.ceil(i1), nc)],
                    numChunks: nc,
                    downsampling,
                  };
                })
                .filter(
                  ({interval}) =>
                    interval[1] - interval[0] < MAX_VIEWED_CHUNKS
                )
                .reverse();

              const max = R.reduce(
                R.maxBy(({interval}) => interval[1] - interval[0]),
                {interval: [0, 0]},
                citvs
              );

              const chunkPromises = R.range(...max.interval).map(
                (chunkIndex) => {
                  const numChunks = max.numChunks;
                  return fetchChunkAt(
                    chunksURL,
                    max.downsampling,
                    channel.index,
                    j,
                    chunkIndex
                  ).then((chunk) => ({
                    interval: [
                      timeInterval[0] +
                        (chunkIndex / numChunks) *
                          (timeInterval[1] - timeInterval[0]),
                      timeInterval[0] +
                        ((chunkIndex + 1) / numChunks) *
                          (timeInterval[1] - timeInterval[0]),
                    ],
                    ...chunk,
                  }));
                }
              );

              return from(
                Promise.all(chunkPromises).then((chunks) => ({
                  channelIndex: channel.index,
                  traceIndex: j,
                  chunks,
                }))
              );
            })
          );
        })
      );

      return from(fetches).pipe(
        Rx.mergeMap(R.identity),
        Rx.toArray(),
      );
    }),
    // @ts-ignore
    Rx.map((payload) => loadChunks(payload))
  );
};
