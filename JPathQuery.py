class JPathQuery:
    key: str
    expression: str
    alt_expression: str
    value: str
    considerAllMatches: False
    jsonDumpRequired: True

    def __init__(self, key_input: str,
                 expression_input: str,
                 alt_expression_input: str = None,
                 considerAllMatches_input: bool = False,
                 jsonDumpRequired_input: bool = True,
                 value_input: str = None):

        self.key = key_input
        self.expression = expression_input
        self.alt_expression = alt_expression_input
        self.considerAllMatches = considerAllMatches_input
        self.considerAllMatches = considerAllMatches_input
        self.jsonDumpRequired = jsonDumpRequired_input
        self.value = value_input
