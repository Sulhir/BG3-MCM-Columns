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

function BlueprintColumn:GetLocaName()
    local columnName = self.ColumnName
    if self:GetHandles() then
        if self:GetHandles().NameHandle then
            local translatedName = Ext.Loca.GetTranslatedString(self:GetHandles().NameHandle)
            if translatedName ~= nil and translatedName ~= "" then
                columnName = translatedName
            end
        end
    end

    return columnName
end

function BlueprintColumn:GetId()
    return self.ColumnId
end

function BlueprintColumn:GetDescription()
    return self.ColumnDescription
end

function BlueprintColumn:GetSettings()
    return self.Settings
end

function BlueprintColumn:SetColumnName(value)
    self.ColumnName = value
end

function BlueprintColumn:GetOptions()
    return self.Options
end

function BlueprintColumn:GetHandles()
    return self.Handles
end
function BlueprintColumn:SetColumnDescription(value)
    self.ColumnDescription = value
end

---@param name string
---@param type string
---@param default MCMSettingValue
---@param description string
---@param options? table<string, unknown>
---@param columnName? string
---@return BlueprintColumn
function BlueprintColumn:AddSetting(name, type, default, description, options, columnnName)
    local setting = BlueprintSetting:New({
        Name = name,
        Type = type,
        Default = default,
        Description = description,
        BlueprintColumn = columnName or self.ColumnName,
        Options = options or {}
    })
    table.insert(self.Settings, setting)
    BlueprintShape:InvalidateCache()
    return self
end
