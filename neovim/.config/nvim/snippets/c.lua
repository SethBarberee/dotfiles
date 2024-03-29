return {
    s("func", {
        -- function, first parameter is the function, second the Placeholders
        -- whose text it gets as input.
        i(1, { "void " }),
        i(2, { "test " }),
        -- Placeholder/Insert.
        i(3),
        t("("),
        -- Placeholder with initial text.
        i(4, "int foo"),
        -- Linebreak
        t({ ") {", "\t" }),
        -- Last Placeholder, exit Point of the snippet. EVERY 'outer' SNIPPET NEEDS Placeholder 0.
        i(0),
        t({ "", "}" }),
    }),

    s("struct", {
        -- struct, first parameter is name and then last placeholder is for the members
        t("struct "),
        i(1, { "test " }),
        -- Placeholder/Insert.
        t({ "{", "\t" }),
        i(0),
        t({ "", "};" }),
    }),

    s("enum", {
        -- enum, first parameter is name and then last placeholder is for the members
        t("enum "),
        i(1, { "test " }),
        -- Placeholder/Insert.
        t({ "{", "\t" }),
        i(0),
        t({ "", "};" }),
    }),
    s("union", {
        -- union, first parameter is name and then last placeholder is for the members
        t("union "),
        i(1, { "test " }),
        -- Placeholder/Insert.
        t({ "{", "\t" }),
        i(0),
        t({ "", "};" }),
    }),


}
