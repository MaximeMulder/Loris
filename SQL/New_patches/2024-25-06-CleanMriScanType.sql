ALTER TABLE `mri_protocol_group_target`
  ADD UNIQUE (`ProjectID`, `CohortID`, `Visit_label`);

ALTER TABLE `mri_protocol`
  RENAME COLUMN `Scan_type` TO `MriScanTypeID`;

ALTER TABLE `mri_protocol_checks`
  RENAME COLUMN `Scan_type` TO `MriScanTypeID`;

ALTER TABLE `mri_violations_log`
  RENAME COLUMN `Scan_type` TO `MriScanTypeID`;

ALTER TABLE `mri_protocol`
  ALTER `MriScanTypeID` DROP DEFAULT;

ALTER TABLE `mri_protocol`
  ADD CONSTRAINT `FK_mri_scan_type_1`
    FOREIGN KEY (`MriScanTypeID`) REFERENCES `mri_scan_type`(`ID`);

ALTER TABLE `mri_violations_log`
  ADD CONSTRAINT `FK_mri_scan_type_1`
    FOREIGN KEY (`MriScanTypeID`) REFERENCES `mri_scan_type`(`ID`);
