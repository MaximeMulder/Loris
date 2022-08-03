SET FOREIGN_KEY_CHECKS=0;
TRUNCATE TABLE `physiological_event_file`;
LOCK TABLES `physiological_event_file` WRITE;

INSERT INTO `physiological_event_file` (`EventFileID`, `PhysiologicalFileID`, `FileType`, `FilePath`, `LastUpdate`, `LastWritten`) VALUES(1, 1, 'tsv', 'bids_imports/Face13_BIDSVersion_1.1.0/sub-OTT167/ses-V1/eeg/sub-OTT167_ses-V1_task-faceO_events.tsv', '2022-07-14 18:51:32', '2022-07-14 18:51:32');
INSERT INTO `physiological_event_file` (`EventFileID`, `PhysiologicalFileID`, `FileType`, `FilePath`, `LastUpdate`, `LastWritten`) VALUES(2, 2, 'tsv', 'bids_imports/Face13_BIDSVersion_1.1.0/sub-OTT168/ses-V1/eeg/sub-OTT168_ses-V1_task-faceO_events.tsv', '2022-07-14 18:51:32', '2022-07-14 18:51:32');
INSERT INTO `physiological_event_file` (`EventFileID`, `PhysiologicalFileID`, `FileType`, `FilePath`, `LastUpdate`, `LastWritten`) VALUES(3, 3, 'tsv', 'bids_imports/Face13_BIDSVersion_1.1.0/sub-OTT174/ses-V1/eeg/sub-OTT174_ses-V1_task-faceO_events.tsv', '2022-07-14 18:51:32', '2022-07-14 18:51:32');
INSERT INTO `physiological_event_file` (`EventFileID`, `PhysiologicalFileID`, `FileType`, `FilePath`, `LastUpdate`, `LastWritten`) VALUES(4, 4, 'tsv', 'bids_imports/Face13_BIDSVersion_1.1.0/sub-OTT176/ses-V1/eeg/sub-OTT176_ses-V1_task-faceO_events.tsv', '2022-07-14 18:51:32', '2022-07-14 18:51:32');
INSERT INTO `physiological_event_file` (`EventFileID`, `PhysiologicalFileID`, `FileType`, `FilePath`, `LastUpdate`, `LastWritten`) VALUES(5, 5, 'tsv', 'bids_imports/Face13_BIDSVersion_1.1.0/sub-OTT175/ses-V1/eeg/sub-OTT175_ses-V1_task-faceO_events.tsv', '2022-07-14 18:51:32', '2022-07-14 18:51:32');
INSERT INTO `physiological_event_file` (`EventFileID`, `PhysiologicalFileID`, `FileType`, `FilePath`, `LastUpdate`, `LastWritten`) VALUES(6, 6, 'tsv', 'bids_imports/Face13_BIDSVersion_1.1.0/sub-OTT172/ses-V1/eeg/sub-OTT172_ses-V1_task-faceO_events.tsv', '2022-07-14 18:51:32', '2022-07-14 18:51:32');
INSERT INTO `physiological_event_file` (`EventFileID`, `PhysiologicalFileID`, `FileType`, `FilePath`, `LastUpdate`, `LastWritten`) VALUES(7, 7, 'tsv', 'bids_imports/Face13_BIDSVersion_1.1.0/sub-OTT170/ses-V1/eeg/sub-OTT170_ses-V1_task-faceO_events.tsv', '2022-07-14 18:51:32', '2022-07-14 18:51:32');
INSERT INTO `physiological_event_file` (`EventFileID`, `PhysiologicalFileID`, `FileType`, `FilePath`, `LastUpdate`, `LastWritten`) VALUES(8, 8, 'tsv', 'bids_imports/Face13_BIDSVersion_1.1.0/sub-OTT173/ses-V1/eeg/sub-OTT173_ses-V1_task-faceO_events.tsv', '2022-07-14 18:51:32', '2022-07-14 18:51:32');
INSERT INTO `physiological_event_file` (`EventFileID`, `PhysiologicalFileID`, `FileType`, `FilePath`, `LastUpdate`, `LastWritten`) VALUES(9, 9, 'tsv', 'bids_imports/Face13_BIDSVersion_1.1.0/sub-OTT171/ses-V1/eeg/sub-OTT171_ses-V1_task-faceO_events.tsv', '2022-07-14 18:51:32', '2022-07-14 18:51:32');
INSERT INTO `physiological_event_file` (`EventFileID`, `PhysiologicalFileID`, `FileType`, `FilePath`, `LastUpdate`, `LastWritten`) VALUES(10, 10, 'tsv', 'bids_imports/Face13_BIDSVersion_1.1.0/sub-OTT166/ses-V1/eeg/sub-OTT166_ses-V1_task-faceO_events.tsv', '2022-07-14 18:51:32', '2022-07-14 18:51:32');

UNLOCK TABLES;
SET FOREIGN_KEY_CHECKS=1;
