curl -XPUT 'localhost:9200/knowledge_manage' -d '{
    "mappings":{
        "information":{
            "properties":{
                "id": {"type":"string"},
                "title": {"type":"string", "index":"analyzed"},
                "scope": {"type":"string", "index":"analyzed"},
                "type": {"type":"string"},
                "items": {"properties" : {"item": {"type":"string"},"type": {"type":"string"}}},
                "lastupdate": {"type" : "date","format" : "date_time"},
                "popularity": {"type":"integer"},
                "cluster": {"type":"string"},
                "master": {"properties":{"where":{"type":"string"}, "filename":{"type":"string"}}},
                "keywords": {"type":"string", "index_name":"keyword","analyzer":"keyword"},
                "facets": {"type":"nested",
                           "properties":{"name": {"type":"string", "index": "not_analyzed"},"foci":{"type":"string","index_name":"focus", "index":    "not_analyzed"}}},
                "kmlinks": {
                    "properties" : {"id": {"type":"string"}}},
                "extlinks": {
                    "properties" : {"name": {"type":"string"},"url":{"type":"string"},"scope": {"type":"string"}}},
                "content": {"type":"string", "index":"not_analyzed"},
                "markup": {"type":"string", "index":"not_analyzed"}
            }
        }
    }
}'