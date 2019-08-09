Prometheus key notes
---
## 1. data models
### internal data models
- data sample, data sample is an item or element comprised of a value and a timestamp.
- time series, a set of data samples which share a common set of pairs of label and its value which identifies the object on which the metric is measured. a metric can be measured on multiple objects, each object can be identified by labels and its values, metric itself can be considered as a meta-label.
- job, it is a configuration which define a set of targets to be scraped, the name of a job will be used as a label for the defined targets when scraping.
- target, it is configuration which defines the object and ways to scrape the object.
### response types
- **Instant vector** - a set of time series containing a single sample for each time series, all sharing the same timestamp
- **Range vector** - a set of time series containing a range of data points over time for each time series
- **Scalar** - a simple numeric floating point value
- **String** - a simple string value; currently unused
 
## 2. HTTP API
### instant query
query the value of a metric at a given time.
```
GET /api/v1/query   
POST /api/v1/query
```
- `query=<string>`: Prometheus expression query string.
- `time=<rfc3339 | unix_timestamp>`: Evaluation timestamp. Optional.
- `timeout=<duration>`: Evaluation timeout. Optional. Defaults to and is capped by the value of the `-query.timeout` flag.

### Range queries
```
GET /api/v1/query_range
POST /api/v1/query_range
```
- `query=<string>`: Prometheus expression query string.
- `start=<rfc3339 | unix_timestamp>`: Start timestamp.
- `end=<rfc3339 | unix_timestamp>`: End timestamp.
- `step=<duration | float>`: Query resolution step width in `duration` format or float number of seconds.
- `timeout=<duration>`: Evaluation timeout. Optional. Defaults to and is capped by the value of the `-query.timeout` flag.
## Querying metadata
### Finding series by label matchers
```
GET /api/v1/series
POST /api/v1/series
```
- `match[]=<series_selector>`: Repeated series selector argument that selects the series to return. At least one `match[]` argument must be provided.
- `start=<rfc3339 | unix_timestamp>`: Start timestamp.
- `end=<rfc3339 | unix_timestamp>`: End timestamp.

Label matchers that match empty label values also select all time series that do not have the specific label set at all. Regex-matches are fully anchored.

**Vector selectors must either specify a name or at least one label matcher that does not match the empty string.** The following expression is illegal:
```
{job=~".*"} # Bad!
```
In contrast, these expressions are valid as they both have a selector that does not match empty label values.
```
{job=~".+"}              # Good!
{job=~".*",method="get"} # Good!
```
Label matchers can also be applied to metric names by matching against the internal `__name__` label. For example, the expression `http_requests_total` is equivalent to `{__name__="http_requests_total"}`.

### Getting label names
```
GET /api/v1/labels
POST /api/v1/labels
```
### Querying label values
```
GET /api/v1/label/<label_name>/values
```
### examples
- list all labels can be used to find out the labels we are interested in.
- list values of label, it is useful to list all metrics in prometheus, `/api/v1/label/__name__/value`, the label `__name__` represent the name of a metric.
- list all metrics exposed by a given job. `/api/v1/series?match[]={job="jobxxx"}`
- query the name of an interested metric which associates with a job.
`/api/v1/series?match[]={job="jobxxx",__name__=".*cpu.*"}`.

## Reference
1. [Query Basics](https://prometheus.io/docs/prometheus/latest/querying/basics/)
2. [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/)