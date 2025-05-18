class CfgDiary {
    class FixedPages {
        class Diary    {
            text = "%TEXT";
        };
        class Tasks {
            text = "%LINK_SET_CURRENT_TASK<br /><br />%TASK_DESCRIPTION";
        };
    };
};

class RscDisplayMainMap {
    #include "DiaryDisplayControls.hpp"
};

class RscDisplayDiary {
    #include "DiaryDisplayControls.hpp"
};

class RscDisplayGetReady: RscDisplayMainMap {
    #include "DiaryDisplayControls.hpp"
};

class RscDisplayServerGetReady: RscDisplayGetReady {
    #include "DiaryDisplayControls.hpp"
};

class RscDisplayClientGetReady: RscDisplayGetReady {
    #include "DiaryDisplayControls.hpp"
};
