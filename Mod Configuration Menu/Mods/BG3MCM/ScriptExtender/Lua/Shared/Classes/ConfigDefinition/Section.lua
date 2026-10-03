---@class BlueprintSection
---@field private SectionName string
---@field private SectionId string
---@field private SectionDescription string
---@field private VisibleIf VisibleIfDefinition
---@field private Options table
---@field private Settings BlueprintSetting[]
---@field private Columns BlueprintColumn[]
---@field private Handles? table
BlueprintSection = _Class:Create("BlueprintSection", nil, {
    SectionName = "",
    SectionId = "",
    SectionDescription = "",
    VisibleIf = "",
    Options = {},
    Tabs = {},
    Settings = {},
    Columns = {},
    Handles = {}
})

---Constructor for the BlueprintSection class.
---@param options table
---@return BlueprintSection
function BlueprintSection:New(options)
    ---@type BlueprintSection
    local self = setmetatable({}, BlueprintSection)
    self.SectionId = options.SectionId or ""
    self.SectionName = options.SectionName or ""
    self.SectionDescription = options.SectionDescription or ""
    self.VisibleIf = options.VisibleIf or ""
    self.Options = options.Options or {}
    self.Tabs = {}
    self.Settings = {}
    self.Columns = {}
    self.Handles = options.Handles

    if options.Tabs then
        for _, tabOptions in ipairs(options.Tabs) do
            local tab = BlueprintTab:New(tabOptions)
            table.insert(self.Tabs, tab)
        end
    end

    if options.Settings then
        for _, settingOptions in ipairs(options.Settings) do
            local setting = BlueprintSetting:New(settingOptions)
            table.insert(self.Settings, setting)
        end
    end
    
    if options.Columns then
        for _, columnOptions in ipairs(options.Columns) do
            local column = BlueprintColumn:New(columnOptions)
            table.insert(self.Columns, column)
        end
    end

    return self
end

function BlueprintSection:GetLocaName()
    local sectionName = self.SectionName
    if self:GetHandles() then
        if self:GetHandles().NameHandle then
            local translatedName = Ext.Loca.GetTranslatedString(self:GetHandles().NameHandle)
            if translatedName ~= nil and translatedName ~= "" then
                sectionName = translatedName
            end
        end
    end

    return sectionName
end

function BlueprintSection:GetId()
    return self.SectionId
end

function BlueprintSection:GetDescription()
    return self.SectionDescription
end

---@return VisibleIfDefinition
function BlueprintSection:GetVisibleIf()
    return self.VisibleIf
end

---Get nested tabs of the BlueprintSection.
---@return BlueprintTab[]
function BlueprintSection:GetTabs()
    return self.Tabs
end

function BlueprintSection:GetSettings()
    return self.Settings
end

function BlueprintSection:SetSectionName(value)
    self.SectionName = value
end

function BlueprintSection:GetOptions()
    return self.Options
end

---Get the columns inside this section.
---@return BlueprintColumn[]
function BlueprintSection:GetColumns()
    return self.Columns
end

function BlueprintSection:GetHandles()
    return self.Handles
end

function BlueprintSection:SetSectionDescription(value)
    self.SectionDescription = value
end

---@param name string
---@param type string
---@param default MCMSettingValue
---@param description string
---@param options? table<string, unknown>
---@param sectionName? string
---@return BlueprintSection
function BlueprintSection:AddSetting(name, type, default, description, options, sectionName)
    local setting = BlueprintSetting:New({
        Name = name,
        Type = type,
        Default = default,
        Description = description,
        BlueprintSection = sectionName or self.SectionName,
        Options = options or {}
    })
    table.insert(self.Settings, setting)
    BlueprintShape:InvalidateCache()
    return self
end

---@param columnName? string
---@param columnDescription? string
---@param options? table<string, unknown>
---@return BlueprintSection
function BlueprintSection:AddColumn(columnName, columnDescription, options)
    local column = BlueprintColumn:New({
        ColumnName = columnName,
        ColumnDescription = columnDescription or "",
        Options = options or {}
    })
    table.insert(self.Columns, column)
    BlueprintShape:InvalidateCache()
    return self
end
