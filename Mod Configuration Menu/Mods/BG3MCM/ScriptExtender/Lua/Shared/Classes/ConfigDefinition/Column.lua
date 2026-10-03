---@class BlueprintColumn
---@field private ColumnName string
---@field private ColumnId string
---@field private ColumnDescription string
---@field private Options table
---@field private Settings BlueprintSetting[]
---@field private Handles? table
BlueprintColumn = _Class:Create("BlueprintColumn", nil, {
    ColumnName = "",
    ColumnId = "",
    ColumnDescription = "",
    Options = {},
    Settings = {},
    Handles = {}
})

--- Constructor for the BlueprintColumn class.
--- @param options table
--- @return BlueprintColumn
function BlueprintColumn:New(options)
    ---@type BlueprintColumn
    local self = setmetatable({}, BlueprintColumn)
    self.ColumnId = options.ColumnId or ""
    self.ColumnName = options.ColumnName or ""
    self.ColumnDescription = options.ColumnDescription or ""
    self.Options = options.Options or {}
    self.Settings = {}
    self.Handles = options.Handles

     if options.Settings then
        for _, settingOptions in ipairs(options.Settings) do
            local setting = BlueprintSetting:New(settingOptions)
            table.insert(self.Settings, setting)
        end
    end

    return self
end


--- Get the unique identifier of this Column block
--- @return string
function BlueprintColumn:GetId()
    return self.ColumnId
end

--- Get the nested settings assigned to this column
--- @return BlueprintSetting[]
function BlueprintColumn:GetSettings()
    return self.Settings
