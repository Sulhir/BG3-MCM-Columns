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
--- @param options table Raw JSON configuration for this column block
function BlueprintColumn:New(options)
    local self = setmetatable({}, BlueprintColumn)
    
    -- Ingest identifying parameters or auto-generate fallback bounds tracking
    self.ColumnId = options.ColumnId or ("col_" .. Ext.Utils.GenerateRandomString(8))
    self.VisibleIf = options.VisibleIf or ""
    self.Handles = options.Handles or {}
    self.Settings = {}

    -- Process settings nested inside this specific backend column group
    if options.Settings and type(options.Settings) == "table" then
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
