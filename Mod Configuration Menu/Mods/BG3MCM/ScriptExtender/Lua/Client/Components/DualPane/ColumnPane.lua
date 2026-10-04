--------------------------------------------
-- ColumnPane Module
-- Manages the columns of the Right Pane
-- Wires columns into the Right Pane
--------------------------------------------

---@class ColumnPane
---@field parent ExtuiTabItem
ColumnPane = _Class:Create("ColumnPane", nil, {})

---columns must only exist inside the Right Pane
---@param parent any 
function ColumnPane:New(parentContainer)
    local this = setmetatable({}, self)
    this.parent = parentContainer
    return this
end

--slice up the right pane into vertical columns
---@param columnsCount number
---@param modUUID string
function ColumnPane:CreateColumnTrack(columnId, modUUID)
    local columnGroup = self.parent:AddGroup(columnId)
    columnGroup.WidthStretch = true
    return columnGroup
end
