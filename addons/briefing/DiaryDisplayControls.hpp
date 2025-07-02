class controls {
    class CA_ContentBackgroundd: RscText {
        w = "21.5 * (((safeZoneW / safeZoneH) min 1.2) / 40) * 2"; // *2 = TMF
    };
    class CA_DiaryGroup: RscControlsGroup {
        w = "21.5 * (((safeZoneW / safeZoneH) min 1.2) / 40) * 2"; // *2 = TMF
        class controls {
            class CA_Diary: RscHTML {
                w = "20.5 * (((safeZoneW / safeZoneH) min 1.2) / 40) * 2"; // *2 = TMF
            };
        };
    };
};
