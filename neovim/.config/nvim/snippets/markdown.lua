local date = function() return { os.date('%Y-%m-%d') } end

return {
    s({
        trig = "blog",
        namr = "blog header",
        dscr = "blog YAML header"
    },
        {
            t({ "---",
                "layout: " }), i(1, "post"), t({ "",
                "title: " }), i(2, "note_title"), t({ "",
                "date: " }), f(date, {}), t({ "",
                "tags: [" }), i(3), t({ "]",
                "---", "" }),
            i(0)
        }),
}
