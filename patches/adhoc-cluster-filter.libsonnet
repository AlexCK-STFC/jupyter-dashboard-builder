// Prepends an ad-hoc filter variable for the `cluster` label so any
// dashboard panel can be filtered by cluster without editing queries.

function(dashboard)
  local existing = std.get(dashboard, 'templating', { list: [] }).list;

  // Reuse an existing datasource template variable if the dashboard
  // defines one, otherwise fall back to a generic name.
  local dsVars = [
    v.name
    for v in existing
    if std.get(v, 'type', '') == 'datasource'
  ];
  local datasourceVarName = if std.length(dsVars) > 0 then dsVars[0] else 'datasource';

  local clusterFilter = {
    name: 'cluster',
    label: 'cluster',
    type: 'adhoc',
    datasource: { type: 'prometheus', uid: '${%s}' % datasourceVarName },
    hide: 0,
    filters: [],
    baseFilters: [
      { key: 'cluster', operator: '=', value: '', condition: '' },
    ],
  };

  dashboard + {
    templating+: {
      list: [clusterFilter] + existing,
    },
  }
