call ale#linter#Define('cpp', {
\   'name': 'pac',
\   'output_stream': 'stdout',
\   'executable': 'pac',
\   'command': 'pac --direct %s',
\   'callback': 'ale#handlers#gcc#HandleGCCFormat',
\})
