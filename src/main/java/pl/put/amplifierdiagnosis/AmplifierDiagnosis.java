package pl.put.amplifierdiagnosis;

import pl.put.amplifierdiagnosis.gui.DiagnosisGUI;

import javax.swing.*;

public class AmplifierDiagnosis {

    public static void main(String[] args) {
        SwingUtilities.invokeLater(DiagnosisGUI::new);
    }
}
