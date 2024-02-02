<!-- Main table -->
{if $show3DViewer|default}
{*<td nowrap="nowrap">the first opening td already opened in main.tpl *}<input type="button" name="button" value="3D Viewer" class="button" id = "dccid" name = "dccid" style = "background-color: #816e91" onclick="window.open('BrainBrowser/display.html?sessionID={$subject.sessionID}')" /></td>

</br>
{/if}
<div>
{$headerTable}
</div>

<div class="panel panel-default">
    <div class="panel-heading" id="panel-main-heading">
{if $files|@count}
        <h3 class="panel-title">{$files|@count} file(s) displayed.</h3>
        <span class="pull-right clickable mri-arrow glyphicon glyphicon-chevron-up"></span>
    </div> <!-- closing panel-heading div-->
    <div class="panel-body">
      {section name=file loop=$files}
          <div id="image-{$files[file].FileID}"></div>
          <script>
            ReactDOM.createRoot(
              document.getElementById("image-{$files[file].FileID}")
            ).render(
              RImagePanel({
                'BaseURL' : "{$baseurl}",

                'FileID'   : "{$files[file].FileID}",
                'Filename' : "{$files[file].Filename}",
                'QCStatus' : "{$files[file].QCStatus}",

                'HasQCPerm': {if $has_qc_permission}true{else}false{/if},
                'FileNew'  : {if $files[file].New}true{else}false{/if},
                "Selected" : "{if $files[file].Selected}{$files[file].Selected}{/if}",

                "Caveat" : "{$files[file].Caveat}",
                "EditableCaveat": "{$files[file].EditableCaveat}",
                "SNR" : "{if $files[file].SNR}{$files[file].SNR}{/if}",
                'infos' : {
                  "SeriesUID" : "{$files[file].SeriesUID}",
                  'XStep' : "{$files[file].Xstep}",
                  'YStep' : "{$files[file].Ystep}",
                  'ZStep' : "{$files[file].Zstep}",
                  'OutputType' : "{$files[file].OutputType}",
                  'CoordinateSpace' : "{$files[file].CoordinateSpace}",
                  "AcquisitionProtocol" : "{$files[file].AcquisitionProtocol}",
                  'AcquisitionDate' : "{$files[file].AcquisitionDate|date_format}",
                  "InsertedDate" : "{$files[file].FileInsertDate|date_format}",
                  "SeriesNumber" : "{$files[file].SeriesNumber}",
                  "SeriesDescription" : "{$files[file].SeriesDescription}",
                  "SliceThickness" : "{$files[file].SliceThickness}",
                  "RepetitionTime" : "{$files[file].RepetitionTime}",
                  "EchoTime" : "{$files[file].EchoTime}",
                  "InversionTime" : "{$files[file].InversionTime}",
                  "PhaseEncodingDirection" : "{$files[file].PhaseEncodingDirection}",
                  "ImageType" : "{$files[file].ImageType}",
                  "EchoNumber" : "{$files[file].EchoNumber}",
                  "NumVolumes" : "{$files[file].Time}",
                  "ProcessingPipeline": "{$files[file].ProcessingPipeline}",
                  "ProcDate": "{$files[file].ProcDate|date_format}",
                  "TotalRejected" : "{$files[file].TotalRejected}",
                  "InterlaceRejected" : "{$files[file].InterlaceRejected}",
                  "IntergradientRejected"  : "{$files[file].IntergradientRejected}",
                  "SlicewiseRejected" : "{$files[file].SlicewiseRejected}"
                },
                files: {
                  minc: "{$files[file].APIFile}",
                  xmlProtocol: "{$files[file].XMLprotocol}",
                  xmlReport: "{$files[file].XMLreport}",
                  nrrd: "{$files[file].NrrdFile}",
                  nifti: "{$files[file].NiiFile}",
                  bval: "{$files[file].BvalFile}",
                  bvec: "{$files[file].BvecFile}",
                  json: "{$files[file].JsonFile}",
                },
                'Fullname' : "{$files[file].FullFilename}",
                "OtherTimepoints" : "{$files[file].OtherTimepoints}",
                "SeriesUID": "{$files[file].SeriesUID}"
              }),
            );
          </script>
       {/section}
   </div> <!-- closing panel-body div-->
{else}
    <h3 class="panel-title">No data available</h3>
   </div> <!-- closing panel-heading div-->
{/if}
</div>
