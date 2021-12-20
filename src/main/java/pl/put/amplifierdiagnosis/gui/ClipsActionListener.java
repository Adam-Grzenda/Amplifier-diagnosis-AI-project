package pl.put.amplifierdiagnosis.gui;

import pl.put.amplifierdiagnosis.clips.ClipsConnector;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import net.sf.clipsrules.jni.*;

import static pl.put.amplifierdiagnosis.gui.DiagnosisGUI.GuiState.*;

public class ClipsActionListener implements ActionListener {


    private final Environment clips = ClipsConnector.getInstance().getClips();
    private final DiagnosisGUI gui;

    private boolean isRunning = false;

    public ClipsActionListener(DiagnosisGUI gui) {
        this.gui = gui;
    }

    @Override
    public void actionPerformed(ActionEvent e) {

        if(isRunning) return;

        try {
            String currentState = getCurrentState();
            ButtonGroup choiceButtons = gui.getChoicesButtons();
            String actionCommand = e.getActionCommand();

            if (actionCommand.equals("Next")) {
                if (choiceButtons.getButtonCount() == 0) {
                    clips.assertString("(next " + currentState + ")");
                    System.out.println("Next state, asserted: " + "(next " + currentState + ")");
                } else {
                    clips.assertString("(next " + choiceButtons.getSelection().getActionCommand() + ")");
                    System.out.println("Next state, asserted: " + "(next " + choiceButtons.getSelection().getActionCommand() + ")");
                }
            } else if (actionCommand.equals("Restart")) {
                clips.reset();
            }
            System.out.println("testy: " + clips.eval("(facts)").toString());
            runClips();
        } catch (Exception ignored) {
        }
    }

    private void nextUIState() throws Exception {
        String currentState = getCurrentState();
        String evalCurrentUIState = "(find-all-facts ((?f UI-state)) (eq ?f:state " + currentState + "))";

        System.out.println("nextUIState: " + currentState);

        MultifieldValue currentUI = (MultifieldValue) clips.eval(evalCurrentUIState);
        FactAddressValue value = (FactAddressValue) currentUI.get(0);

        if (currentState.equals("final")) {
            gui.setGuiState(FINAL);
        } else if (currentState.equals("initial")) {
            gui.setGuiState(INITIAL);
        } else {
            gui.setGuiState(NEXT);
        }

        MultifieldValue validAnswers = (MultifieldValue) value.getSlotValue("answers");

        gui.setChoices(validAnswers, "selected");

        String text = value.getSlotValue("display").toString();

        gui.setLabelText(text);

        isRunning = false;
    }

    private String getCurrentState() throws Exception{
        String findStateID = "(find-all-facts ((?f CurrentState)) TRUE)";
        return ((FactAddressValue) (((MultifieldValue) clips.eval(findStateID)).get(0))).getSlotValue("state").toString();
    }

    private void runClips() {
        isRunning = true;
        SwingUtilities.invokeLater(
                () -> {
                    try {
                        clips.run();
                        nextUIState();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
        );
    }

}
