; extends
;; highlight sql inside any function call .query(` `) template string
(call_expression
  function: (member_expression
			  property: (property_identifier) @property (#eq? @property "query"))
  arguments: (arguments
			  (template_string (string_fragment) @injection.content
					   (#set! injection.language "sql"))))
