#!/bin/bash
sleep 10
curl --header "Content-Type: application/json" \
    --request POST \
    --data '
{
  "paragraphs": [
    {
      "text": "%spark\nimport org.apache.spark.sql.SparkSession \nimport org.apache.spark._ \nval sqlContext = spark.sqlContext\nval conf = sc.getConf\nval customSql = SparkSession.builder.config(conf).enableHiveSupport().getOrCreate()\ncustomSql.sql(\"show databases\").show\ncustomSql.sql(\"show tables\").show",
      "user": "anonymous",
      "dateUpdated": "2020-05-11T18:58:24+0000",
      "config": {
        "editorSetting": {
          "language": "scala",
          "editOnDblClick": false,
          "completionKey": "TAB",
          "completionSupport": true
        },
        "colWidth": 12,
        "editorMode": "ace/mode/scala",
        "fontSize": 9,
        "results": {},
        "enabled": true
      },
      "settings": {
        "params": {},
        "forms": {}
      },
      "apps": [],
      "runtimeInfos": {},
      "progressUpdateIntervalMs": 500,
      "jobName": "paragraph_1589220779743_-1064196611",
      "id": "paragraph_1588648461104_124765922",
      "dateCreated": "2020-05-11T18:12:59+0000",
      "dateStarted": "2020-05-11T18:54:31+0000",
      "dateFinished": "2020-05-11T18:54:31+0000",
      "status": "FINISHED",
      "focus": true,
      "$$hashKey": "object:3211"
    },
    {
      "text": "%spark.sql\nuse tpcds_csv;\n select cast(amc as decimal(15,4))/cast(pmc as decimal(15,4)) am_pm_ratio\n from ( select count(*) amc\n       from web_sales, household_demographics , time_dim, web_page\n       where ws_sold_time_sk = time_dim.t_time_sk\n         and ws_ship_hdemo_sk = household_demographics.hd_demo_sk\n         and ws_web_page_sk = web_page.wp_web_page_sk\n         and time_dim.t_hour between 8 and 8+1\n         and household_demographics.hd_dep_count = 6\n         and web_page.wp_char_count between 5000 and 5200) at cross join\n      ( select count(*) pmc\n       from web_sales, household_demographics , time_dim, web_page\n       where ws_sold_time_sk = time_dim.t_time_sk\n         and ws_ship_hdemo_sk = household_demographics.hd_demo_sk\n         and ws_web_page_sk = web_page.wp_web_page_sk\n         and time_dim.t_hour between 19 and 19+1\n         and household_demographics.hd_dep_count = 6\n         and web_page.wp_char_count between 5000 and 5200) pt\n order by am_pm_ratio\n limit 100",
      "user": "anonymous",
      "dateUpdated": "2020-05-11T18:58:16+0000",
      "config": {
        "editorSetting": {
          "language": "sql",
          "editOnDblClick": false,
          "completionKey": "TAB",
          "completionSupport": true
        },
        "colWidth": 12,
        "editorMode": "ace/mode/sql",
        "fontSize": 9,
        "results": {
          "0": {
            "graph": {
              "mode": "table",
              "height": 300,
              "optionOpen": false,
              "setting": {
                "table": {
                  "tableGridState": {},
                  "tableColumnTypeState": {
                    "names": {
                      "am_pm_ratio": "string"
                    },
                    "updated": false
                  },
                  "tableOptionSpecHash": "[{\"name\":\"useFilter\",\"valueType\":\"boolean\",\"defaultValue\":false,\"widget\":\"checkbox\",\"description\":\"Enable filter for columns\"},{\"name\":\"showPagination\",\"valueType\":\"boolean\",\"defaultValue\":false,\"widget\":\"checkbox\",\"description\":\"Enable pagination for better navigation\"},{\"name\":\"showAggregationFooter\",\"valueType\":\"boolean\",\"defaultValue\":false,\"widget\":\"checkbox\",\"description\":\"Enable a footer for displaying aggregated values\"}]",
                  "tableOptionValue": {
                    "useFilter": false,
                    "showPagination": false,
                    "showAggregationFooter": false
                  },
                  "updated": false,
                  "initialized": false
                }
              },
              "commonSetting": {}
            }
          }
        },
        "enabled": true
      },
      "settings": {
        "params": {},
        "forms": {}
      },
      "apps": [],
      "runtimeInfos": {
        "jobUrl": {
          "propertyName": "jobUrl",
          "label": "SPARK JOB",
          "tooltip": "View in Spark web UI",
          "group": "spark",
          "values": [
            {
              "jobUrl": "http://alexbdcun0.bmbdcsad1.bmbdcs.oraclevcn.com:4040/jobs/job?id=14",
              "$$hashKey": "object:3339"
            },
            {
              "jobUrl": "http://alexbdcun0.bmbdcsad1.bmbdcs.oraclevcn.com:4040/jobs/job?id=15",
              "$$hashKey": "object:3340"
            },
            {
              "jobUrl": "http://alexbdcun0.bmbdcsad1.bmbdcs.oraclevcn.com:4040/jobs/job?id=16",
              "$$hashKey": "object:3341"
            },
            {
              "jobUrl": "http://alexbdcun0.bmbdcsad1.bmbdcs.oraclevcn.com:4040/jobs/job?id=17",
              "$$hashKey": "object:3342"
            },
            {
              "jobUrl": "http://alexbdcun0.bmbdcsad1.bmbdcs.oraclevcn.com:4040/jobs/job?id=18",
              "$$hashKey": "object:3343"
            },
            {
              "jobUrl": "http://alexbdcun0.bmbdcsad1.bmbdcs.oraclevcn.com:4040/jobs/job?id=19",
              "$$hashKey": "object:3344"
            }
          ],
          "interpreterSettingId": "spark"
        }
      },
      "progressUpdateIntervalMs": 500,
      "jobName": "paragraph_1589220779747_1351933764",
      "id": "paragraph_1589219819218_715852138",
      "dateCreated": "2020-05-11T18:12:59+0000",
      "dateStarted": "2020-05-11T18:58:16+0000",
      "dateFinished": "2020-05-11T18:58:19+0000",
      "status": "FINISHED",
      "$$hashKey": "object:3212"
    },
    {
      "text": "%spark.sql\n",
      "user": "anonymous",
      "dateUpdated": "2020-05-11T18:14:02+0000",
      "config": {
        "colWidth": 12,
        "fontSize": 9,
        "enabled": true,
        "results": {},
        "editorSetting": {
          "language": "sql",
          "editOnDblClick": false,
          "completionKey": "TAB",
          "completionSupport": true
        },
        "editorMode": "ace/mode/sql"
      },
      "settings": {
        "params": {},
        "forms": {}
      },
      "apps": [],
      "runtimeInfos": {},
      "progressUpdateIntervalMs": 500,
      "jobName": "paragraph_1589220842658_1198294043",
      "id": "paragraph_1589220842658_1198294043",
      "dateCreated": "2020-05-11T18:14:02+0000",
      "status": "READY",
      "$$hashKey": "object:3213"
    }
  ],
  "name": "Oracle Spark examples",
  "id": "2F983Q4XW",
  "defaultInterpreterGroup": "spark",
  "version": "0.9.0-preview1",
  "noteParams": {},
  "noteForms": {},
  "angularObjects": {},
  "config": {
    "isZeppelinNotebookCronEnable": false,
    "looknfeel": "default",
    "personalizedMode": "false"
  },
  "info": {
    "isRunning": false
  },
  "path": "/Oracle Spark examples"
} ' http://localhost:8080/api/notebook/import

