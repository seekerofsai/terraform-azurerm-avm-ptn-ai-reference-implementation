resource "azurerm_application_insights_workbook" "avm_ootb_workbook" {
  data_json = jsonencode(
    {
      "version" : "Notebook/1.0",
      "items" : [
        {
          "type" : 9,
          "name" : "Dashboard Parameters",
          "content" : {
            "version" : "KqlParameterItem/1.0",
            "parameters" : [
              {
                "version" : "KqlParameterItem/1.0",
                "name" : "TimeRange",
                "label" : "Time Range",
                "type" : 4,
                "isRequired" : true,
                "value" : {
                  "durationMs" : 3600000
                },
                "typeSettings" : {
                  "selectableValues" : [
                    {
                      "durationMs" : 1800000
                    },
                    {
                      "durationMs" : 3600000
                    },
                    {
                      "durationMs" : 14400000
                    },
                    {
                      "durationMs" : 43200000
                    },
                    {
                      "durationMs" : 86400000
                    },
                    {
                      "durationMs" : 172800000
                    },
                    {
                      "durationMs" : 259200000
                    },
                    {
                      "durationMs" : 604800000
                    },
                    {
                      "durationMs" : 1209600000
                    },
                    {
                      "durationMs" : 2592000000
                    }
                  ],
                  "allowCustom" : false
                },
                "id" : "5e667d25-3e05-431b-9d32-73f8bdf06168"
              }
            ]
          },
          "styleSettings" : {
            "w" : 24,
            "h" : 2,
            "x" : 0,
            "y" : 0,
            "showBorder" : false,
            "borderStyle" : "light thick",
            "margin" : "20px 0 0 0​"
          },
          "id" : "28bf5321-78be-4634-9709-26c45a96dbec"
        },
        {
          "type" : 3,
          "name" : "qryRecordperTable",
          "content" : {
            "version" : "KqlItem/1.0",
            "title" : "Records per Table",
            "query" : "// Counts by table names\nunion withsource=[\"$TableName\"] *\n| summarize Count=count() by TableName=[\"$TableName\"]\n| render piechart",
            "size" : 0,
            "queryType" : 0,
            "resourceType" : "microsoft.operationalinsights/workspaces",
            "crossComponentResources" : [
              module.log_analytics_workspace.resource.id
            ],
            "timeContextFromParameter" : "TimeRange"
          },
          "styleSettings" : {
            "showBorder" : true,
            "borderStyle" : "light thick",
            "margin" : "5px",
            "padding" : "7px 5px 15px 15px",
            "w" : 6,
            "h" : 15,
            "x" : 0,
            "y" : 2
          },
          "id" : "40aed2c9-7eba-4172-9b38-508f400784ee"
        },
        {
          "type" : 3,
          "name" : "qryDiagnosticRecordsByResource",
          "content" : {
            "version" : "KqlItem/1.0",
            "title" : "Diagnostic Entries by Resource",
            "query" : format("%s%s%s", "AzureDiagnostics\n| where tolower(ResourceGroup) == tolower('", var.resource_group_name, "')\n| project Resource\n| summarize count() by Resource\n| render columnchart "),
            "size" : 0,
            "queryType" : 0,
            "resourceType" : "microsoft.operationalinsights/workspaces",
            "crossComponentResources" : [
              module.log_analytics_workspace.resource.id
            ],
            "timeContextFromParameter" : "TimeRange"
          },
          "styleSettings" : {
            "showBorder" : true,
            "borderStyle" : "light thick",
            "margin" : "5px",
            "padding" : "7px 5px 15px 15px",
            "w" : 7,
            "h" : 15,
            "x" : 6,
            "y" : 2
          },
          "id" : "f4a8f2f5-30d3-4d11-b43a-78c8690e5a50"
        }
      ],
      "layout" : {
        "type" : "grid"
      },
      "fallbackResourceIds" : [
        "Azure Monitor"
      ]
    }
  )
  display_name        = "AVM AI Reference Implementation - OOTB Workbook"
  location            = var.location
  name                = uuid()
  resource_group_name = var.resource_group_name
  tags                = var.tags
}
