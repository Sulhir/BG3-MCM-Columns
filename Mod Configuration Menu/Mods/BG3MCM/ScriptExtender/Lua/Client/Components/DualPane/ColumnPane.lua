--------------------------------------------
-- ColumnPane Module
-- Manages the columns of the Right Pane
-- Wires columns into the Right Pane
--------------------------------------------

---@class ColumnPane
---@field parent ExtuiTabItem
ColumnPane = _Class:Create("ColumnPane", nil, {})

---columns must only exist inside the Right Pane
---@param parentContainer any 
function ColumnPane:New(parentContainer)
    local this = setmetatable({}, self)
    this.parent = parentContainer
    return this
end

--slice up the right pane into vertical columns
---@param columnId string
---@param modUUID string
---@param columnsCount number
function ColumnPane:CreateColumnTrack(columnId, modUUID)
    if not columnsCount or columnsCount == 0 then return {} end
    local ColumnTableId = "ColumnPaneGrid_" .. modUUID
    local layoutTable = self.parent:AddTable(ColumnTableId, columnsCount)
    layoutTable.BordersOuter = false
    layoutTable.BordersInner = false
    layoutTable.RowBg = false
    
        for i = 1, columnsCount do
            self.layoutTable:AddColumn("Track_" .. i, "WidthStretch")
        end
    
    local columnRow = layoutTable:AddRow()
    local trackContainers = {}
    
    for i = 1, columnsCount do
        table.insert(trackContainers, columnRow:AddCell())
    end
    return trackContainers
end
