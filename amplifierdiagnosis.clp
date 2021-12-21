(deftemplate CurrentState
(slot state)
)

(deftemplate UI-state
(slot display)
(slot state)
(multislot answers)
)

(deffacts init
(CurrentState (state initial))
)

(defrule starting-screen ""
    =>
        (assert
            (UI-state (display StartingMessage) (state initial) (answers StartYes StartNo))
        )
)

(defrule startYes
    ?f1 <- (CurrentState (state initial))
    ?f2 <- (next StartYes)
    =>
    (retract ?f2)
    (modify ?f1 (state SoundProblem))
    (assert
        (UI-state (display SoundProblem) (state SoundProblem) (answers SoundProblemA1 SoundProblemA2))
    )
)

(defrule startNo
    ?f1 <- (CurrentState (state initial))
    ?f2 <- (next StartNo)
    =>
    (retract ?f2)
)

(defrule SoundProblemA1
    ?f1 <- (CurrentState (state SoundProblem))
    ?f2 <- (next SoundProblemA1)
    =>
    (retract ?f2)
    (modify ?f1 (state NoSound))
    (assert
        (UI-state (display NoSound) (state NoSound) (answers NoSoundA1 NoSoundA2))
    )
)

(defrule NoSoundA1
    ?f1 <- (CurrentState (state NoSound))
    ?f2 <- (next NoSoundA1)
    =>
    (retract ?f2)
    (modify ?f1 (state LampsLighted))
    (assert
        (UI-state (display LampsLighted) (state LampsLighted) (answers LampsLightedA1 LampsLightedA2))
    )
)

(defrule NoSoundA2
    ?f1 <- (CurrentState (state NoSound))
    ?f2 <- (next NoSoundA2)
    =>
    (retract ?f2)
    (modify ?f1 (state LampsNotLighted))
    (assert
        (UI-state (display LampsNotLighted) (state LampsNotLighted) (answers LampsNotLightedA1 LampsNotLightedA2))
    )
)

(defrule LampsLightedA1
    ?f1 <- (CurrentState (state LampsLighted))
    ?f2 <- (next LampsLightedA1)
    =>
    (retract ?f2)
    (modify ?f1 (state Hum))
    (assert
        (UI-state (display Hum) (state Hum) (answers HumA1 HumA2))
    )
)

(defrule LampsLightedA2
    ?f1 <- (CurrentState (state LampsLighted))
    ?f2 <- (next LampsLightedA2)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display ControlsNotAdjustedFinal) (state final))
    )
)

(defrule HumA1
    ?f1 <- (CurrentState (state Hum))
    ?f2 <- (next HumA1)
    =>
    (retract ?f2)
    (modify ?f1 (state Substitute))
    (assert
        (UI-state (display Substitute) (state Substitute) (answers SubstituteA1 SubstituteA2))
    )
)

(defrule HumA2
    ?f1 <- (CurrentState (state Hum))
    ?f2 <- (next HumA2)
    =>
    (retract ?f2)
    (modify ?f1 (state TouchTip))
    (assert
        (UI-state (display TouchTip) (state TouchTip) (answers TouchTipA1 TouchTipA2))
    )
)

(defrule SubstituteA1
    ?f1 <- (CurrentState (state Substitute))
    ?f2 <- (next SubstituteA1)
    =>
    (retract ?f2)
    (modify ?f1 (state SubstituteNoSound))
    (assert
        (UI-state (display SubstituteNoSound) (state SubstituteNoSound) (answers SubstituteNoSoundA1 SubstituteNoSoundA2))
    )
)

(defrule SubstituteA2
    ?f1 <- (CurrentState (state Substitute))
    ?f2 <- (next SubstituteA2)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display TubesWrongFinal) (state final))
    )
)

(defrule TouchTipA1
    ?f1 <- (CurrentState (state TouchTip))
    ?f2 <- (next TouchTipA1)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display NoChangeHumFinal) (state final))
    )
)

(defrule TouchTipA2
    ?f1 <- (CurrentState (state TouchTip))
    ?f2 <- (next TouchTipA2)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display LoudHumFinal) (state final))
    )
)

(defrule SubstituteNoSoundA1
    ?f1 <- (CurrentState (state SubstituteNoSound))
    ?f2 <- (next SubstituteNoSoundA1)
    =>
    (retract ?f2)
    (modify ?f1 (state NoClicks))
    (assert
        (UI-state (display NoClicks) (state NoClicks) (answers NoClicksA1 NoClicksA2))
    )
)

(defrule SubstituteNoSoundA2
    ?f1 <- (CurrentState (state SubstituteNoSound))
    ?f2 <- (next SubstituteNoSoundA2)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display CompetentRepairServiceFinal) (state final))
    )
)

(defrule NoClicksA1
    ?f1 <- (CurrentState (state NoClicks))
    ?f2 <- (next NoClicksA1)
    =>
    (retract ?f2)
    (modify ?f1 (state ClicksAudibleCheckLeads))
    (assert
        (UI-state (display ClicksAudibleCheckLeads) (state ClicksAudibleCheckLeads) (answers ClicksAudibleCheckLeadsA1 ClicksAudibleCheckLeadsA2))
    )
)


(defrule LampsNotLightedA1
    ?f1 <- (CurrentState (state LampsNotLighted))
    ?f2 <- (next LampsNotLightedA1)
    =>
    (retract ?f2)
    (modify ?f1 (state ReplaceFuse))
    (assert
        (UI-state (display ReplaceFuse) (state ReplaceFuse) (answers ReplaceFuseA1 ReplaceFuseA2))
    )
)

(defrule LampsNotLightedA2
    ?f1 <- (CurrentState (state LampsNotLighted))
    ?f2 <- (next LampsNotLightedA2)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display NoVoltageFinal) (state final))
    )
)

(defrule ReplaceFuseA1
    ?f1 <- (CurrentState (state ReplaceFuse))
    ?f2 <- (next ReplaceFuseA1)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display CheckCordPlugOnOffFinal) (state final))
    )
)

(defrule ReplaceFuseA2
    ?f1 <- (CurrentState (state ReplaceFuse))
    ?f2 <- (next ReplaceFuseA2)
    =>
    (retract ?f2)
    (modify ?f1 (state FuseBlownSubstitute))
    (assert
        (UI-state (display FuseBlownSubstitute) (state FuseBlownSubstitute) (answers FuseBlownSubstituteA1 FuseBlownSubstituteA2))
    )
)

(defrule FuseBlownSubstituteA1
    ?f1 <- (CurrentState (state FuseBlownSubstitute))
    ?f2 <- (next FuseBlownSubstituteA1)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display ShortedTubeFinal) (state final))
    )
)

(defrule FuseBlownSubstituteA2
    ?f1 <- (CurrentState (state FuseBlownSubstitute))
    ?f2 <- (next FuseBlownSubstituteA2)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display CompetentRepairServiceFinal) (state final))
    )
)




(defrule NoClicksA2
    ?f1 <- (CurrentState (state NoClicks))
    ?f2 <- (next NoClicksA2)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display VoiceCoilOnSpeakerOpenFinal) (state final))
    )
)

(defrule ClicksAudibleCheckLeadsA1
    ?f1 <- (CurrentState (state ClicksAudibleCheckLeads))
    ?f2 <- (next ClicksAudibleCheckLeadsA1)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display CompetentRepairServiceFinal) (state final))
    )
)

(defrule ClicksAudibleCheckLeadsA2
    ?f1 <- (CurrentState (state ClicksAudibleCheckLeads))
    ?f2 <- (next ClicksAudibleCheckLeadsA2)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display RepairLeadsFinal) (state final))
    )
)




(defrule SoundProblemA2
    ?f1 <- (CurrentState (state SoundProblem))
    ?f2 <- (next SoundProblemA2)
    =>
    (retract ?f2)
    (modify ?f1 (state DistortedSound))
    (assert
        (UI-state (display DistortedSound) (state DistortedSound) (answers DistortedSoundA1 DistortedSoundA2))
    )
)


(defrule DistortedSoundA1
    ?f1 <- (CurrentState (state DistortedSound))
    ?f2 <- (next DistortedSoundA1)
    =>
    (retract ?f2)
    (modify ?f1 (state AllChannelsDistorted))
    (assert
        (UI-state (display AllChannelsDistorted) (state AllChannelsDistorted) (answers AllChannelsDistortedA1 AllChannelsDistortedA2))
    )
)

(defrule AllChannelsDistortedA1
    ?f1 <- (CurrentState (state AllChannelsDistorted))
    ?f2 <- (next AllChannelsDistortedA1)
    =>
    (retract ?f2)
    (modify ?f1 (state AllPoorSound))
    (assert
        (UI-state (display AllPoorSound) (state AllPoorSound) (answers AllPoorSoundA1 AllPoorSoundA2))
    )
)

(defrule AllChannelsDistortedA2
    ?f1 <- (CurrentState (state AllChannelsDistorted))
    ?f2 <- (next AllChannelsDistortedA2)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display ProperControlDistortedFinal) (state final))
    )
)

(defrule AllPoorSoundA1
    ?f1 <- (CurrentState (state AllPoorSound))
    ?f2 <- (next AllPoorSoundA1)
    =>
    (retract ?f2)
    (modify ?f1 (state AllPoorSoundFirmlySeated))
    (assert
        (UI-state (display AllPoorSoundFirmlySeated) (state AllPoorSoundFirmlySeated) (answers AllPoorSoundFirmlySeatedA1 AllPoorSoundFirmlySeatedA2))
    )
)

(defrule AllPoorSoundA2
    ?f1 <- (CurrentState (state AllPoorSound))
    ?f2 <- (next AllPoorSoundA2)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display RepairInstrumentPickupCableFinal) (state final))
    )
)

(defrule AllPoorSoundFirmlySeatedA1
    ?f1 <- (CurrentState (state AllPoorSoundFirmlySeated))
    ?f2 <- (next AllPoorSoundFirmlySeatedA1)
    =>
    (retract ?f2)
    (modify ?f1 (state AllPoorSoundFirmlySeatedPoorSound))
    (assert
        (UI-state (display AllPoorSoundFirmlySeatedPoorSound) (state AllPoorSoundFirmlySeatedPoorSound) (answers AllPoorSoundFirmlySeatedPoorSoundA1 AllPoorSoundFirmlySeatedPoorSoundA2))
    )
)

(defrule AllPoorSoundFirmlySeatedPoorSoundA1
    ?f1 <- (CurrentState (state AllPoorSoundFirmlySeatedPoorSound))
    ?f2 <- (next AllPoorSoundFirmlySeatedPoorSoundA1)
    =>
    (retract ?f2)
    (modify ?f1 (state AllPoorSeatedNoImprov))
    (assert
        (UI-state (display AllPoorSeatedNoImprov) (state AllPoorSeatedNoImprov) (answers AllPoorSeatedNoImprovA1 AllPoorSeatedNoImprovA2))
    )
)

(defrule AllPoorSoundFirmlySeatedPoorSoundA2
    ?f1 <- (CurrentState (state AllPoorSoundFirmlySeatedPoorSound))
    ?f2 <- (next AllPoorSoundFirmlySeatedPoorSoundA2)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display OutputTubeReplacedFinal) (state final))
    )
)

(defrule AllPoorSeatedNoImprovA2
    ?f1 <- (CurrentState (state AllPoorSeatedNoImprov))
    ?f2 <- (next AllPoorSeatedNoImprovA2)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display ReplacedRectifierFinal) (state final))
    )
)

(defrule AllPoorSeatedNoImprovA1
    ?f1 <- (CurrentState (state AllPoorSeatedNoImprov))
    ?f2 <- (next AllPoorSeatedNoImprovA1)
    =>
    (retract ?f2)
    (modify ?f1 (state AllPoorSeatedNoRect))
    (assert
        (UI-state (display AllPoorSeatedNoRect) (state AllPoorSeatedNoRect) (answers AllPoorSeatedNoRectA1 AllPoorSeatedNoRectA2))
    )
)


(defrule AllPoorSeatedNoRectA1
    ?f1 <- (CurrentState (state AllPoorSeatedNoRect))
    ?f2 <- (next AllPoorSeatedNoRectA1)
    =>
    (retract ?f2)
    (modify ?f1 (state TestSpeaker))
    (assert
        (UI-state (display TestSpeaker) (state TestSpeaker) (answers TestSpeakerA1 TestSpeakerA2))
    )
)

(defrule TestSpeakerA1
    ?f1 <- (CurrentState (state TestSpeaker))
    ?f2 <- (next TestSpeakerA1)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display ReplaceSpeakerFinal) (state final))
    )
)

(defrule TestSpeakerA2
    ?f1 <- (CurrentState (state TestSpeaker))
    ?f2 <- (next TestSpeakerA2)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display CompetentRepairServiceFinal) (state final))
    )
)


(defrule AllPoorSeatedNoRectA2
    ?f1 <- (CurrentState (state AllPoorSeatedNoRect))
    ?f2 <- (next AllPoorSeatedNoRectA2)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display NewRestOfTubesFinal) (state final))
    )
)

(defrule AllPoorSoundFirmlySeatedA2
    ?f1 <- (CurrentState (state AllPoorSoundFirmlySeated))
    ?f2 <- (next AllPoorSoundFirmlySeatedA2)
    =>
    (retract ?f2)
    (modify ?f1 (state FirmlySeatedFinal))
    (assert
        (UI-state (display FirmlySeatedFinal) (state final))
    )
)




(defrule DistortedSoundA2
    ?f1 <- (CurrentState (state DistortedSound))
    ?f2 <- (next DistortedSoundA2)
    =>
    (retract ?f2)
    (modify ?f1 (state CheckPreamp))
    (assert
        (UI-state (display CheckPreamp) (state CheckPreamp) (answers CheckPreampA1 CheckPreampA2))
    )
)

(defrule CheckPreampA1
    ?f1 <- (CurrentState (state CheckPreamp))
    ?f2 <- (next CheckPreampA1)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display CompetentRepairServiceFinal) (state final))
    )
)

(defrule CheckPreampA2
    ?f1 <- (CurrentState (state CheckPreamp))
    ?f2 <- (next CheckPreampA2)
    =>
    (retract ?f2)
    (modify ?f1 (state final))
    (assert
        (UI-state (display SoundOKPreampFinal) (state final))
    )
)


























