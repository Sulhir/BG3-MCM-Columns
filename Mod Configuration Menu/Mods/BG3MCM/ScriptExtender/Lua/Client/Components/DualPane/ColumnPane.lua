--------------------------------------------
-- ColumnController Module
-- Manages the columns of the Right Pane
-- Wires columns into the Right Pane
--------------------------------------------

---@class ColumnController
---@field parent ExtuiTabItem
ColumnController = _Class:Create("ColumnController", nil, {})

--columns must only exist inside the Right Pane
---@param parent any 
function ColumnController:New(parentContainer
    local this = setmetatable({}, self)
    this.parent = parentContainer
    return this
end

--slice up the right pane into vertical columns
---@param columnsCount number
---@param modUUID string
---@return any columnRow
function ColumnController:CreateGrid(columnsCount, modUUID)
  if not columnsCount or columnsCount == 0 then return nil end
