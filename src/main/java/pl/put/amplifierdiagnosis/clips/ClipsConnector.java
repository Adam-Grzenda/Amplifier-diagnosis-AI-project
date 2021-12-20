package pl.put.amplifierdiagnosis.clips;


import net.sf.clipsrules.jni.CLIPSException;
import net.sf.clipsrules.jni.Environment;

public class ClipsConnector {
    private final Environment clips;

    private static ClipsConnector clipsConnector;

    public static ClipsConnector getInstance(){
        if (clipsConnector == null) {
            try {
                clipsConnector = new ClipsConnector();
            } catch (CLIPSException e) {
                e.printStackTrace();
                System.exit(-1);
            }
        }
        return clipsConnector;
    }

    private ClipsConnector() throws CLIPSException {
        clips = new Environment();
        clips.load("amplifierdiagnosis.clp");
        clips.reset();
    }

    public Environment getClips(){
        return clips;
    }



}
