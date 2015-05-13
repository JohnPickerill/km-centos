curl -XPUT 'localhost:9200/knowledge_manage' -d '{
    "mappings":{
        "information":{
            "properties":{
                "id": {"type":"string", "index":"analyzed","analyzer":"keyword"},
                "title": {"type":"string", "index":"analyzed", "analyzer":"english"},
                "scope": {"type":"string", "index":"analyzed", "analyzer":"english"},
                "type": {"type":"string", "index":"no"},
                "items": {"properties" : {"item": {"type":"string"},"type": {"type":"string"}}},
                "lastupdate": {"type" : "date","format" : "date_time"},
                "popularity": {"type":"integer", "index":"analyzed","analyzer":"keyword"},
                "cluster": {"type":"string", "index": "not_analyzed"},
                "master": {"properties":{"where":{"type":"string", "index":"no"}, "filename":{"type":"string", "index":"no"}}},
                "keywords": {"type":"string", "index_name":"keyword","analyzer":"keyword"},
                "facets": {"type":"nested",
                           "properties":{"name": {"type":"string", "index": "not_analyzed"},"foci":{"type":"string","index_name":"focus", "index":"not_analyzed"}}},
                "kmlinks": {
                    "properties" : {"id": {"type":"string"}}},
                "extlinks": {
                    "properties" : {"name": {"type":"string", "index":"no"},"url":{"type":"string","index":"no"},"scope": {"type":"string"}}},
                "content": {"type":"string", "index":"no"},
                "markup": {"type":"string", "index":"no"}
            }
        }
    }
}'