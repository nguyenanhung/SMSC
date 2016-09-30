let OUserRID = SELECT @rid FROM OUser WHERE name = 'admin';
let Dashboard = SELECT FROM (SELECT expand(classes) FROM metadata:schema) WHERE name = 'Dashboard';

if ($DashboardBox.size() == 0) {
  console.log "Dashboard class not exists! Start creating process."

  CREATE Class Dashboard
  CREATE PROPERTY Dashboard.name STRING
  CREATE PROPERTY Dashboard.icon STRING
  CREATE PROPERTY Dashboard.user LINK OUser

  ALTER PROPERTY Dashboard.name MANDATORY true
  ALTER PROPERTY Dashboard.icon MANDATORY true
  ALTER PROPERTY Dashboard.user MANDATORY true

  CREATE INDEX UNIQUE_NAME_USER ON Dashboard (name, user) UNIQUE

  let defaultDashboard = INSERT INTO Dashboard SET name = 'default', icon = 'user', user = $OUserRID

  console.log "Creating process for Dashboard class is done."

  let DashboardBoxType = SELECT FROM (SELECT expand(classes) FROM metadata:schema) WHERE name = 'DashboardBoxType';

  if (DashboardBoxType.size() == 0) {
    console.log "DashboardBoxType class not exists! Start creating process."

    CREATE Class DashboardBoxType

    CREATE PROPERTY DashboardBoxType.name STRING
    CREATE PROPERTY DashboardBoxType.code STRING
    CREATE PROPERTY DashboardBoxType.codeLanguage STRING

    ALTER PROPERTY DashboardBoxType.name MANDATORY true
    ALTER PROPERTY DashboardBoxType.code MANDATORY true
    ALTER PROPERTY DashboardBoxType.codeLanguage CUSTOM type='SQL,JavaScript'

    CREATE INDEX DashboardBoxType.name UNIQUE

    let statusType = INSERT INTO DashboardBoxType SET name = 'status', code = '', codeLanguage = 'SQL'
    let chartType = INSERT INTO DashboardBoxType SET name = 'chart', code = '', codeLanguage = 'SQL'

    console.log "Creating process for DashboardBoxType class is done."
  }

  let DashboardBox = SELECT FROM (SELECT expand(classes) FROM metadata:schema) WHERE name = 'DashboardBox';

  if ($DashboardBox.size() == 0) {
    console.log "DashboardBox class not exists! Start creating process."

    CREATE Class DashboardBox

    CREATE PROPERTY DashboardBox.width INTEGER
    CREATE PROPERTY DashboardBox.height INTEGER
    CREATE PROPERTY DashboardBox.order INTEGER
    CREATE PROPERTY DashboardBox.name STRING
    CREATE PROPERTY DashboardBox.description STRING
    CREATE PROPERTY DashboardBox.dashboard LINK Dashboard
    CREATE PROPERTY DashboardBox.type LINK DashboardBoxType

    ALTER PROPERTY DashboardBox.width MANDATORY true
    ALTER PROPERTY DashboardBox.height MANDATORY true
    ALTER PROPERTY DashboardBox.order MANDATORY true
    ALTER PROPERTY DashboardBox.name MANDATORY true
    ALTER PROPERTY DashboardBox.description MANDATORY true
    ALTER PROPERTY DashboardBox.dashboard MANDATORY true
    ALTER PROPERTY DashboardBox.type MANDATORY true

    CREATE INDEX UNIQUE_DASHBOARD_ORDER ON DashboardBox (dashboard, order) UNIQUE

    INSERT INTO DashboardBox SET width = 25, height = 25, order = 1, dashboard = $defaultDashboard['@rid'], type = $statusType['@rid'], name = 'Box 1', description = 'Box 1 desc'
    INSERT INTO DashboardBox SET width = 25, height = 25, order = 2, dashboard = $defaultDashboard['@rid'], type = $statusType['@rid'], name = 'Box 2', description = 'Box 2 desc'
    INSERT INTO DashboardBox SET width = 25, height = 25, order = 3, dashboard = $defaultDashboard['@rid'], type = $statusType['@rid'], name = 'Box 3', description = 'Box 3 desc'
    INSERT INTO DashboardBox SET width = 25, height = 25, order = 4, dashboard = $defaultDashboard['@rid'], type = $statusType['@rid'], name = 'Box 4', description = 'Box 4 desc'

    INSERT INTO DashboardBox SET width = 50, height = 25, order = 5, dashboard = $defaultDashboard['@rid'], type = $chartType['@rid'], name = 'Box 5', description = 'Box 5 desc'
    INSERT INTO DashboardBox SET width = 50, height = 25, order = 6, dashboard = $defaultDashboard['@rid'], type = $chartType['@rid'], name = 'Box 6', description = 'Box 6 desc'

    console.log "Creating process for DashboardBox class is done."
  }
}

return true
