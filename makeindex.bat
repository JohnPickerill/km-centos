curl -XPUT 'localhost:9200/knowledge_manage' -d '{      "settings": {
        "analysis": {
          "filter": {
            "synonyms_expand" : {
                  "synonyms_path" : "analysis/synonym.txt",
                   "type" : "synonym"
                },
            "synonyms_contract" : {
                   "expand" : 0,
                   "synonyms" : [
                      "jpx,charge"
                   ],
                   "type" : "synonym"
             },
            "english_stop": {
              "type":       "stop",
              "stopwords":  "_english_" 
            },
            "english_keywords": {
              "type":       "keyword_marker",
              "keywords":   ["jpxxx"] 
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
            "cc_english": {
              "tokenizer":  "standard",
              "filter": [
                "english_possessive_stemmer",
                "lowercase",
                "english_stop",
                "english_stemmer"
              ]},
             "cc_english_q": {
              "tokenizer":  "standard",
              "filter": [
                "english_possessive_stemmer",
                "lowercase",
                "english_stop",
                "synonyms_expand",
                "english_stemmer"
              ]}
              "cc_keyword": {
                "tokenizer":  "keyword",
                "filter": ["lowercase"]
              }
            
          }  
        
      }
    },
    "mappings":{
        "information":{
            "properties":{
                "id": {"type":"string", "index":"analyzed","analyzer":"cc_keyword"},
                "title": {"type":"string", "index":"analyzed", "index_analyzer":"cc_english",  "search_analyzer":"cc_english_q"},
                "scope": {"type":"string", "index":"analyzed", "index_analyzer":"cc_english",  "search_analyzer":"cc_english_q"},
                "type": {"type":"string", "index":"no"},
                "items": {"properties" : {"item": {"type":"string"},"type": {"type":"string"}}},
                "lastupdate": {"type" : "date","format" : "date_time"},
                "popularity": {"type":"integer", "index":"analyzed","analyzer":"cc_keyword"},
                "cluster": {"type":"string", "index": "not_analyzed"},
                "master": {"properties":{"where":{"type":"string", "index":"no"}, "filename":{"type":"string", "index":"no"}}},
                "status": {"type":"string", "index":"no"}
                "author": {"type":"string", "index":"no"}
                "keywords": {"type":"string", "index_name":"keyword","analyzer":"cc_keyword"},
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