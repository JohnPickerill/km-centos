curl -XGET 'localhost:9203/knowledge_manage/information/_search' -d '{
"query":{"multi_match":{"query":"johnp","fields":["keywords^5","title","scope"]}},
"aggs":{"nest":{"nested":{"path":"facets"},
"aggs":{"facetnames":{"terms":{"field":"facets.name"},
"aggs":{"focinames":{"terms": {"field":"facets.foci"}}}}}}}}'        
 


  