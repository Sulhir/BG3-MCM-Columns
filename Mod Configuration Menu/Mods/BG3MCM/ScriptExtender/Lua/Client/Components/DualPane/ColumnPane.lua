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
    if not self.layoutTable then
        local ColumnTableId = "ColumnPaneGrid_" .. modUUID .. "_" .. columnId
        self.layoutTable = self.parent:AddTable(ColumnTableId, columnsCount)
        self.layoutTable.BordersOuter = false
        self.layoutTable.BordersInner = false
        self.layoutTable.RowBg = false

        for i = 1, columnsCount do
            self.layoutTable:AddColumn("Track_" .. i, "WidthStretch")
        end

        self.columnRow = self.layoutTable:AddRow()
    end
    
    local cellContainer = self.columnRow:AddCell()
    return cellContainer
end
