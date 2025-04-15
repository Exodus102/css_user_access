<?php
require('../fpdf186/fpdf.php');
require('../FPDI-2.6.3/src/autoload.php');

use setasign\Fpdi\Fpdi;

$pdf = new FPDI();

$pageCount = $pdf->setSourceFile("../template-pdf/NCAR-Form-template.pdf");

$templateId = $pdf->importPage(1);

$pdf->AddPage();
$pdf->useTemplate($templateId);

$pdf->SetFont('Arial', '', 10);
$pdf->SetTextColor(0, 0, 0);

$pdf->SetLineWidth(0.8);
$pdf->Line(20, 45, 190, 45);
$pdf->SetLineWidth(0.8);

$pdf->SetFont('Arial', 'B', 12.5);

$text = "NON-CONFORMITY and CORRECTIVE ACTION REPORT (NCAR)";
$textWidth = $pdf->GetStringWidth($text);
$x = (210 - $textWidth) / 2;
$pdf->SetXY($x, 50);
$pdf->Write(5, $text);

$pdf->SetFont('Arial', '', 10);

$pdf->SetXY(20, 60);
$pdf->Write(5, "NCAR No.: Automated");

$pdf->SetXY(120, 60);
$pdf->Write(5, "Date: " . date("Y-m-d"));

$pdf->SetLineWidth(0.2);

$pdf->SetFont('Arial', 'B', 10);
// Data for the first cell
$unitData = "Unit: Your Unit Name Here\nSection Clause No. (for IQA only): Your Section/Clause Data Here";

$lineHeight = 5;

// Calculate the height needed for the first cell
$numberOfLines = ceil($pdf->GetStringWidth($unitData) / 170); // Full width
$totalHeight = $lineHeight * $numberOfLines;

// First cell
$pdf->SetXY(20, 70);
$pdf->MultiCell(170, $lineHeight, $unitData, 1, 'L', false);

// Data for the second cell (checkboxes)
$checkboxData = "1. Details: \t\t\tNon-conformity raised as a result of:\n" .
    "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t[ ] Material, Product or Equipment\t\t\t\t\t\t\t[ ] Unmet Quality Objectives\n" .
    "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t[ ] Customer Complaints\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t[ ] Service Non-conformity\n" .
    "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t[ ] Internal Quality Audit\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t[ ] Improvement\n" .
    "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t[ ] Clientele Satisfaction Survey\t\t\t\t\t\t\t\t\t\t\t[ ] Others";

// Calculate the height for the second cell
$numberOfLinesCheckbox = ceil($pdf->GetStringWidth($checkboxData) / 170); // Full width
$totalHeightCheckbox = $lineHeight * $numberOfLinesCheckbox;
$pdf->SetFont('Arial', '', 10);
// Second cell - Position UNDER the first cell (CORRECTED Y-coordinate)
$pdf->SetXY(20, 75 + $totalHeight);
$pdf->MultiCell(170, $lineHeight, $checkboxData, 1, 'L', false);

// Data for the third cell (description)
$descriptionData = "2.  Description of:  [  ] Non-Conformity          [  ] Improvement\n" .
    "Comment\n" . "Directed by:           Date: ";

// Calculate the height for the third cell
$numberOfLinesDescription = ceil($pdf->GetStringWidth($descriptionData) / 170); // Full width
$totalHeightDescription = $lineHeight * $numberOfLinesDescription;

// Third cell - Position UNDER the second cell (CORRECTED Y-coordinate)
$pdf->SetXY(20, 80 + $totalHeight + $totalHeightCheckbox);
$pdf->MultiCell(170, $lineHeight, $descriptionData, 1, 'L', false);

// Data for the fourth cell (Disposition)
$dispositionData = "3. Disposition: [Applicable for Material/Product or Equipment only]\n" .
    "[ ] Rework/Repair        [ ] Use as is             [ ] N/A\n" .
    "[ ] Reject & return to supplier        [ ] Other\n" .
    "Proposed by:                                Date: ";

// Calculate the height for the fourth cell
$numberOfLinesDisposition = ceil($pdf->GetStringWidth($dispositionData) / 170); // Full width
$totalHeightDisposition = $lineHeight * $numberOfLinesDisposition;

// Fourth cell - Position UNDER the third cell (CORRECTED Y-coordinate)
$pdf->SetXY(20, 85 + $totalHeight + $totalHeightCheckbox + $totalHeightDescription + 5);
$pdf->MultiCell(170, $lineHeight, $dispositionData, 1, 'L', false);

// Data for the fifth cell (Correction)
$correctionData = "4. [ ] Correction (Immediate Action): [ ] Not Applicable\n\nResponsible Person/s:                                Date: ";

// Calculate the height for the fifth cell
$numberOfLinesCorrection = ceil($pdf->GetStringWidth($correctionData) / 170);
$totalHeightCorrection = $lineHeight * $numberOfLinesCorrection;

// Fifth cell - Position UNDER the fourth cell
$pdf->SetXY(20, 95 + $totalHeight + $totalHeightCheckbox + $totalHeightDescription + $totalHeightDisposition + 5);
$pdf->MultiCell(170, $lineHeight, $correctionData, 1, 'L', false);

// Data for the sixth cell (Root Cause Analysis)
$rootCauseData = "5. Root Cause Analysis: [ ] Non-conformity [ ] Not Applicable\n\nInvestigated by:                                Date:\n\nConforme:                                Date: ";

// Calculate the height for the sixth cell
$numberOfLinesRootCause = ceil($pdf->GetStringWidth($rootCauseData) / 170);
$totalHeightRootCause = $lineHeight * $numberOfLinesRootCause;

// Sixth cell - Position UNDER the fifth cell
$pdf->SetXY(20, 105 + $totalHeight + $totalHeightCheckbox + $totalHeightDescription + $totalHeightDisposition + $totalHeightCorrection + 5);
$pdf->MultiCell(170, $lineHeight, $rootCauseData, 1, 'L', false);

// Data for the seventh cell (Corrective Action)
$correctiveActionData = "6. [ ] Corrective Action: [ ] Improvement\n\nResponsible:                                Date: ";

// Calculate the height for the seventh cell
$numberOfLinesCorrectiveAction = ceil($pdf->GetStringWidth($correctiveActionData) / 170);
$totalHeightCorrectiveAction = $lineHeight * $numberOfLinesCorrectiveAction;

// Seventh cell - Position UNDER the sixth cell
$pdf->SetXY(20, 120 + $totalHeight + $totalHeightCheckbox + $totalHeightDescription + $totalHeightDisposition + $totalHeightCorrection + $totalHeightRootCause + 5);
$pdf->MultiCell(170, $lineHeight, $correctiveActionData, 1, 'L', false);

// Data for the eighth cell (Follow-up Implementation)
$followUpData = "7. Follow-up Implementation of Action:\n[ ] Satisfactory Remarks:                                [ ] Not satisfactory\nName & Signature:                                Date: ";

// Calculate the height for the eighth cell
$numberOfLinesFollowUp = ceil($pdf->GetStringWidth($followUpData) / 170);
$totalHeightFollowUp = $lineHeight * $numberOfLinesFollowUp;

// Eighth cell - Position UNDER the seventh cell
$pdf->SetXY(20, 130 + $totalHeight + $totalHeightCheckbox + $totalHeightDescription + $totalHeightDisposition + $totalHeightCorrection + $totalHeightRootCause + $totalHeightCorrectiveAction + 5);
$pdf->MultiCell(170, $lineHeight, $followUpData, 1, 'L', false);

// Data for the ninth cell (Verification of Effectiveness)
$verificationData = "8. Verification on the effectiveness of action: To be completed by the ISO Chairperson or Unit Head\n[ ] Satisfactory                                [ ] Not satisfactory (issue new NCAR)\nRemarks:\nVerified by: _______________ Print Name _______________ Signature _______________ Date";

// Calculate the height for the ninth cell
$numberOfLinesVerification = ceil($pdf->GetStringWidth($verificationData) / 170);
$totalHeightVerification = $lineHeight * $numberOfLinesVerification;

// Ninth cell - Position UNDER the eighth cell
$pdf->SetXY(20, 135 + $totalHeight + $totalHeightCheckbox + $totalHeightDescription + $totalHeightDisposition + $totalHeightCorrection + $totalHeightRootCause + $totalHeightCorrectiveAction + $totalHeightFollowUp + 5);
$pdf->MultiCell(170, $lineHeight, $verificationData, 1, 'L', false);

$pdf->Output('I', 'NCAR-Filled.pdf');
