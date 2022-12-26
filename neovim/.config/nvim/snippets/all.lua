local date = function() return { os.date('%Y-%m-%d') } end

return {
    s("trig", t("loaded!!")),
    s("date", f(date, {}))
}
