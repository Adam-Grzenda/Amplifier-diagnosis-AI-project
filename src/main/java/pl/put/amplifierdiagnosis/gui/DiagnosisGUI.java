package pl.put.amplifierdiagnosis.gui;

import net.sf.clipsrules.jni.MultifieldValue;

import javax.swing.*;
import java.awt.*;
import java.util.Locale;
import java.util.ResourceBundle;

public class DiagnosisGUI {


    public enum GuiState {
        NEXT,
        FINAL,
        INITIAL
    }

    private final JFrame jFrame;
    private final JLabel jLabel;

    private final JPanel choicesPanel;
    private final ResourceBundle resources;

    private ButtonGroup choicesButtons;


    private final JButton nextButton;


    public DiagnosisGUI() {
        resources = ResourceBundle.getBundle("AmplifierDiagnosis", new Locale("en", "EN"));
        jFrame = new JFrame(resources.getString("AmplifierDiagnosis"));
        initJFrame();

        JPanel displayPanel = new JPanel();
        jLabel = new JLabel();
        displayPanel.add(jLabel);

        choicesPanel = new JPanel();
        choicesButtons = new ButtonGroup();


        JPanel buttonPanel = new JPanel();

        nextButton = new JButton(resources.getString("Start"));
        nextButton.setActionCommand("Next");
        nextButton.addActionListener(new ClipsActionListener(this));

        buttonPanel.add(nextButton);

        jFrame.getContentPane().add(displayPanel);
        jFrame.getContentPane().add(choicesPanel);
        jFrame.getContentPane().add(buttonPanel);


        jFrame.setVisible(true);
    }

    private void initJFrame() {
        jFrame.getContentPane().setLayout(new GridLayout(3, 1));
        jFrame.setSize(1280, 720);
        jFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }


    public void setGuiState(GuiState state) {
        switch(state) {
            case INITIAL:
                nextButton.setActionCommand("Start");
                nextButton.setText(resources.getString("Start"));
            case NEXT:
                nextButton.setActionCommand("Next");
                nextButton.setText(resources.getString("Next"));
                break;
            case FINAL:
                nextButton.setActionCommand("Restart");
                nextButton.setText(resources.getString("Restart"));
                nextButton.setVisible(true);
                break;
        }
    }

    public void setChoices(MultifieldValue validAnswers, String selected) throws Exception {
        choicesPanel.removeAll();
        choicesButtons = new ButtonGroup();

        for (int i = 0; i < validAnswers.size(); i++) {
            String choice = validAnswers.get(i).toString();

            JRadioButton button = selected.equals(choice) ?
                new JRadioButton(resources.getString(choice), true)
                    : new JRadioButton(resources.getString(choice), false);
            button.setActionCommand(choice);
            choicesPanel.add(button);
            choicesButtons.add(button);
        }
        choicesPanel.repaint();
    }

    public void setLabelText(String resourceName) {
        jLabel.setText(resources.getString(resourceName));
    }

    public ButtonGroup getChoicesButtons() {
        return choicesButtons;
    }

}
