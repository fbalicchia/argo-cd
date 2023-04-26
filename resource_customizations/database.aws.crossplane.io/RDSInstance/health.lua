hs = {}
readyStatus = ""
readyReason = ""
syncedStatus = ""
syncedReason = ""

if obj.status ~= nil then
  if obj.status.conditions ~= nil then
    for i, condition in ipairs(obj.status.conditions) do
      if condition.type == "Ready" then
        readyStatus=condition.status
        readyReason=condition.reason
      end
      if condition.type == "Synced" then
        syncedStatus=condition.status
        syncedReason=condition.reason
      end
    end
  end
end

if syncedStatus == "False" then
  hs.status = "Degraded"
  hs.message = "Degraded because RDS is not synced"
elseif readyStatus == "False" then
  if readyReason == "Creating" then
    hs.status = "Progressing"
    hs.message = "Waiting for database creation"
  elseif readyReason == "Deleting" then
    hs.status = "Progressing"
    hs.message = "Waiting for database deletion"
  elseif readyReason == "Unavailable" then
    hs.status = "Degraded"
    hs.message = "Degraded because RDS is unavailable"
  end
else 
  hs.status = "Healthy"
  hs.message = "RDS is ready and synced"
end
return hs