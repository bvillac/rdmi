<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\models;

use Yii;
use mPDF;

class ExportFile {

    /**
     * Send the PDF document in browser with a specific name. The plug-in is used if available.
     * The name given by filename is used when one selects the "Save as" option on the link generating the PDF.
     * @var string
     */
    const OUTPUT_TO_BROWSER = "I";

    /**
     * Forcing the download of PDF via web browser, with a specific name
     * @var string
     */
    const OUTPUT_TO_DOWNLOAD = "D";

    /**
     * Write the contents of a PDF file on the server
     * @var string
     */
    const OUTPUT_TO_FILE = "F";

    /**
     * Retrieve the contents of the PDF and then do whatever you want
     * @var string
     */
    const OUTPUT_TO_STRING = "S";

    public $mpdf;
    public $mode = 'utf-8';
    public $format = 'A4';
    public $default_font_size = '';
    public $default_font = '';
    public $mgl = 15;
    public $mgr = 15;
    public $mgt = 10;
    public $mgb = 10;
    public $mgh = 5;
    public $mgf = 7;
    public $orientation = 'P';
    public $footer = TRUE;
    public $typeExport = "";
    public $reportName = "";

    function __construct() {
        if ($this->reportName == "")
            $this->reportName = 'Reporte_' . date("Ymdhis");
        if ($this->typeExport = "")
            $this->typeExport = self::OUTPUT_TO_DOWNLOAD;
    }

    function createReportPdf($content) {
        $this->mpdf = new mPDF(
                $this->mode, 
                $this->format, 
                $this->default_font_size, 
                $this->default_font, 
                $this->mgl, 
                $this->mgr, 
                $this->mgt, 
                $this->mgb, 
                $this->mgh, 
                $this->mgf, 
                $this->orientation);
        if ($this->footer)
            $this->mpdf->SetHTMLFooter("<div class='footer' style='font-size: 10px;'><div style='float: left; width: 50%;'>Pag: {PAGENO}</div><div style='float: left;width: 50%;text-align: right;'>Hora: " . date("H:i") . "</div></div>");
        $this->mpdf->WriteHTML($content);
    }
}
