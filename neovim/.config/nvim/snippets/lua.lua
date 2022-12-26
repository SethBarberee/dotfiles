return {
    s("req", {
        t "require('",
        i(1, "Module-name"),
        t "')",
        i(0),
    }),
    s("if", {
        t "if ",
        i(1),
        t { " then", "\t" },
        i(2),
        t { "", "end", "" },
        i(0),
    }),
}
