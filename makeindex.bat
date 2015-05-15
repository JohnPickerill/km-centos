curl -XPUT 'localhost:9200/knowledge_manage' -d '{
       "settings": {
        "analysis": {
          "filter": {
            "english_stop": {
              "type":       "stop",
              "stopwords":  "_english_" 
            },
            "english_keywords": {
              "type":       "keyword_marker",
              "keywords":   ["lllllll"] 
            },
            "english_stemmer": {
              "type":       "stemmer",
              "language":   "english"
            },
            "english_possessive_stemmer": {
              "type":       "stemmer",
              "language":   "possessive_english"
            }
          },        
          "analyzer": {
            "johnp_english": {
              "tokenizer":  "standard",
              "filter": [
                "english_possessive_stemmer",
                "lowercase",
                "english_stop",
                "english_stemmer"
              ]
            },
            "johnp_english_q": {
              "tokenizer":  "standard",
              "filter": [
                "english_possessive_stemmer",
                "lowercase",
                "english_stop",
                "english_keywords",
                "english_stemmer"
              ]
            }
            }
        }
      },   
    "mappings":{
        "information":{
            "properties":{
                "id": {"type":"string", "index":"analyzed","analyzer":"keyword"},
                "title": {"type":"string", "index":"analyzed", "index_analyzer":"johnp_english",  "search_analyzer":"johnp_english_q"},
                "scope": {"type":"string", "index":"analyzed", "index_analyzer":"johnp_english",  "search_analyzer":"johnp_english_q"},
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
                    "properties" : {"id": {"type":"string","index":"not_analyzed"}}},
                "extlinks": {
                     "properties" : {"name": {"type":"string", "index":"no"},"url":{"type":"string","index":"no"},"scope": {"type":"string"}}},
                 "content": {"type":"string", "index":"no"},
                "markup": {"type":"string", "index":"no"}
            }
        }
    }
}'