// Registry of patches applied to every rendered dashboard, in order.
// Each patch is a function (dashboard) -> dashboard.

local patches = [
  (import 'adhoc-cluster-filter.libsonnet'),
  // (import 'some-future-patch.libsonnet'),
];

{
  apply(dashboard)::
    std.foldl(function(d, patch) patch(d), patches, dashboard),
}
