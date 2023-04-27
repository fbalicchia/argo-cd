hs = {}
hs.status = "Progressing"
hs.message = ""
if obj.status ~= nil then
  if obj.status.health ~= nil then
    hs.status = obj.status.health.status
    if obj.status.health.message ~= nil then
      hs.message = obj.status.health.message
    end
    if hs.status == "Healthy" then
      for i, group in ipairs(obj.status.resources) do
        if group.health ~= nil and group.health.status ~= nil and group.health.status ~= "Healthy" then
          hs.status = group.health.status
          hs.message = "Leaf Applications " .. group.health.status
        end
      end
    end
  end
end
return hs