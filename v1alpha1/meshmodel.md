# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [meshmodel.proto](#meshmodel.proto)
    - [Canary](#easemesh.v1alpha1.Canary)
    - [CanaryRule](#easemesh.v1alpha1.CanaryRule)
    - [CanaryRule.HeadersEntry](#easemesh.v1alpha1.CanaryRule.HeadersEntry)
    - [CanaryRule.ServiceInstanceLabelsEntry](#easemesh.v1alpha1.CanaryRule.ServiceInstanceLabelsEntry)
    - [CircuitBreaker](#easemesh.v1alpha1.CircuitBreaker)
    - [CircuitBreakerPolicy](#easemesh.v1alpha1.CircuitBreakerPolicy)
    - [CustomResourceKind](#easemesh.v1alpha1.CustomResourceKind)
    - [HTTPMatch](#easemesh.v1alpha1.HTTPMatch)
    - [HTTPRouteGroup](#easemesh.v1alpha1.HTTPRouteGroup)
    - [IdentityBindingSubject](#easemesh.v1alpha1.IdentityBindingSubject)
    - [Ingress](#easemesh.v1alpha1.Ingress)
    - [IngressPath](#easemesh.v1alpha1.IngressPath)
    - [IngressRule](#easemesh.v1alpha1.IngressRule)
    - [LoadBalance](#easemesh.v1alpha1.LoadBalance)
    - [Mock](#easemesh.v1alpha1.Mock)
    - [MockRule](#easemesh.v1alpha1.MockRule)
    - [MockRule.HeadersEntry](#easemesh.v1alpha1.MockRule.HeadersEntry)
    - [Observability](#easemesh.v1alpha1.Observability)
    - [ObservabilityMetrics](#easemesh.v1alpha1.ObservabilityMetrics)
    - [ObservabilityMetricsDetail](#easemesh.v1alpha1.ObservabilityMetricsDetail)
    - [ObservabilityOutputServer](#easemesh.v1alpha1.ObservabilityOutputServer)
    - [ObservabilityTracings](#easemesh.v1alpha1.ObservabilityTracings)
    - [ObservabilityTracingsDetail](#easemesh.v1alpha1.ObservabilityTracingsDetail)
    - [ObservabilityTracingsOutputConfig](#easemesh.v1alpha1.ObservabilityTracingsOutputConfig)
    - [RateLimiter](#easemesh.v1alpha1.RateLimiter)
    - [RateLimiterPolicy](#easemesh.v1alpha1.RateLimiterPolicy)
    - [Resilience](#easemesh.v1alpha1.Resilience)
    - [Retryer](#easemesh.v1alpha1.Retryer)
    - [RetryerPolicy](#easemesh.v1alpha1.RetryerPolicy)
    - [Service](#easemesh.v1alpha1.Service)
    - [ServiceInstance](#easemesh.v1alpha1.ServiceInstance)
    - [ServiceInstance.LabelsEntry](#easemesh.v1alpha1.ServiceInstance.LabelsEntry)
    - [Sidecar](#easemesh.v1alpha1.Sidecar)
    - [StringMatch](#easemesh.v1alpha1.StringMatch)
    - [Tenant](#easemesh.v1alpha1.Tenant)
    - [TimeLimiter](#easemesh.v1alpha1.TimeLimiter)
    - [TrafficTarget](#easemesh.v1alpha1.TrafficTarget)
    - [TrafficTargetRule](#easemesh.v1alpha1.TrafficTargetRule)
    - [URLRule](#easemesh.v1alpha1.URLRule)
  
- [Scalar Value Types](#scalar-value-types)



<a name="meshmodel.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## meshmodel.proto
Copyright 2021 MegaEase
  Licensed under the Apache License, Version 2.0 (the &#34;License&#34;);
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an &#34;AS IS&#34; BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.


<a name="easemesh.v1alpha1.Canary"></a>

### Canary
Canary configures rules to implement canary deployment. It belongs to the traffic scheduling domain.
The developer can deploy a canary version of microservice and accept coloring test its stability before
rolling out to the whole instances.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| canaryRules | [CanaryRule](#easemesh.v1alpha1.CanaryRule) | repeated | CanaryRules is the mesh service&#39;s all rules for canary deployment. |






<a name="easemesh.v1alpha1.CanaryRule"></a>

### CanaryRule
CanaryRule define the rule for canary deployment. Including service instances labels,
how to match colored traffic, which traffic is considered as coloring.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| serviceInstanceLabels | [CanaryRule.ServiceInstanceLabelsEntry](#easemesh.v1alpha1.CanaryRule.ServiceInstanceLabelsEntry) | repeated | ServiceInstanceLabels configure the labels patched into the service instances. Registry center will label it to corresponding instances during deployment. It&#39;s optional. It indicates the canary target service instances. The relation between elements in this map is &#34;OR&#34;. |
| headers | [CanaryRule.HeadersEntry](#easemesh.v1alpha1.CanaryRule.HeadersEntry) | repeated | Headers configure HTTP requests matching configurations with &#34;OR&#34; relation. Once HTTP requests match one element in this array, it will be regarded as the colored traffic. |
| urls | [URLRule](#easemesh.v1alpha1.URLRule) | repeated | Urls describe the HTTP request matching schemes for this canary rule. |






<a name="easemesh.v1alpha1.CanaryRule.HeadersEntry"></a>

### CanaryRule.HeadersEntry



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  |  |
| value | [StringMatch](#easemesh.v1alpha1.StringMatch) |  |  |






<a name="easemesh.v1alpha1.CanaryRule.ServiceInstanceLabelsEntry"></a>

### CanaryRule.ServiceInstanceLabelsEntry



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  |  |
| value | [string](#string) |  |  |






<a name="easemesh.v1alpha1.CircuitBreaker"></a>

### CircuitBreaker
CircuitBreaker is used for blocking all in-coming requests when the the failure numbers
reach the configured limitation. You can declare an CircuitBreaker with COUNT_BASED or
TIME_BASED type.  It has three types of states, open, closed and half-close. One service
can declare its desired CircuitBreaker, and the upstream clients will active the same CircuitBreaker
locally when calling this service.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| policies | [CircuitBreakerPolicy](#easemesh.v1alpha1.CircuitBreakerPolicy) | repeated | Policies contain different breaker configurations for this CircuitBreaker to use. |
| defaultPolicyRef | [string](#string) |  | DefaultPolicyRef is the default reference policy name. |
| urls | [URLRule](#easemesh.v1alpha1.URLRule) | repeated | URLs describe the HTTP request matching schemes for this limiter to filter. |






<a name="easemesh.v1alpha1.CircuitBreakerPolicy"></a>

### CircuitBreakerPolicy
CircuitBreakerPolicy is the policy for describing Resilience component CircuitBreaker.
It contains the basic configurations for the breaker, including the type of sliding window this
breaker will use. Whether including network error or not and so on.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | Name is the identify of this policy. |
| slidingWindowType | [string](#string) |  | SlidingWindowType is the sliding window type of this break, only &#34;COUNT_BASED&#34; or &#34;TIME_BASED&#34; allowed. |
| failureRateThreshold | [uint32](#uint32) |  | FailureRateThreshold configures the failure rate threshold in percentage. When the failure rate is equal or greater than the threshold the CircuitBreaker transitions to open and starts short-circuiting calls. |
| slowCallRateThreshold | [uint32](#uint32) |  | SlowCallRateThreshold Configures a threshold in percentage. The CircuitBreaker considers a call as slow when the call duration is greater than slowCallDurationThreshold When the percentage of slow calls is equal or greater the threshold, the CircuitBreaker transitions to open and starts short-circuiting calls. |
| countingNetworkError | [bool](#bool) |  | CountingNetworkError configures whether a network failure situation should active CircuitBreaker or not. . |
| slidingWindowSize | [uint32](#uint32) |  | SlidingWindowSize configures the size of the sliding window which is used to record the outcome of calls when the CircuitBreaker is closed. |
| permittedNumberOfCallsInHalfOpenState | [uint32](#uint32) |  | PermittedNumberOfCallsInHalfOpenState configures the number of permitted calls when the CircuitBreaker is half open. |
| minimumNumberOfCalls | [uint32](#uint32) |  | MinimumNumberOfCalls configures the minimum number of calls which are required (per sliding window period) before the CircuitBreaker can calculate the error rate or slow call rate. For example, if minimumNumberOfCalls is 10, then at least 10 calls must be recorded, before the failure rate can be calculated. If only 9 calls have been recorded the CircuitBreaker will not transition to open even if all 9 calls have failed. |
| slowCallDurationThreshold | [string](#string) |  | SlowCallDurationThreshold configures the duration threshold above which calls are considered as slow and increase the rate of slow calls. |
| maxWaitDurationInHalfOpenState | [string](#string) |  | MaxWaitDurationInHalfOpenState configures a maximum wait duration which controls the longest amount of time a CircuitBreaker could stay in Half Open state, before it switches to open. Value 0 means Circuit Breaker would wait infinitely in HalfOpen State until all permitted calls have been completed. |
| waitDurationInOpenState | [string](#string) |  | WaitDurationInOpenState configures the duration that the CircuitBreaker should wait before transitioning from open to half-open,e.g.,60000ms. |
| failureStatusCodes | [int32](#int32) | repeated | FailureStatusCodes is the array for HTTP failure status code for this CircuitBreakerPolicy. |






<a name="easemesh.v1alpha1.CustomResourceKind"></a>

### CustomResourceKind
CustomResourceKind defines a custom resource kind.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | Name is the name of the custom resource kind. |
| jsonSchema | [google.protobuf.Struct](#google.protobuf.Struct) |  | JSONSchema is the json schema to validate a custom resource of this kind. |






<a name="easemesh.v1alpha1.HTTPMatch"></a>

### HTTPMatch
HTTPMatch defines an individual route for HTTP traffic.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | Name is the name of the HTTP match. |
| methods | [string](#string) | repeated | Methods configures allowed HTTP method string, e.g. &#34;GET&#34;,&#34;DELETE&#34;,&#34;POST&#34;. |
| pathRegex | [string](#string) |  | PathRegex is a regular expression defining the route. |






<a name="easemesh.v1alpha1.HTTPRouteGroup"></a>

### HTTPRouteGroup
HTTPRouteGroup defines the spec of a HTTP route group.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | Name is the name for referencing a HTTPRouteGroup. |
| matches | [HTTPMatch](#easemesh.v1alpha1.HTTPMatch) | repeated | Matches is a list of HTTPMatch to match traffic. |






<a name="easemesh.v1alpha1.IdentityBindingSubject"></a>

### IdentityBindingSubject
IdentityBindingSubject is a subject which should be allowed access to the TrafficTarget.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| kind | [string](#string) |  | Kind is the type of Subject to allow access, must be &#34;Service&#34; by now. |
| name | [string](#string) |  | Name of the Subject, i.e. ServiceName. |






<a name="easemesh.v1alpha1.Ingress"></a>

### Ingress
Ingress is the spec of mesh ingress.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | Name is the identify of this ingress. |
| rules | [IngressRule](#easemesh.v1alpha1.IngressRule) | repeated | Rules is an array of ingress routing rules. |






<a name="easemesh.v1alpha1.IngressPath"></a>

### IngressPath
IngressPath is the path for a mesh ingress rule


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| path | [string](#string) |  | Path is a regular expression for matching the target HTTP URL. |
| rewriteTarget | [string](#string) |  | RewriteTarget is a regular expression for rewriting original URL when the HTTP URL path match the Path field. |
| backend | [string](#string) |  | Backend is the mesh service&#39;s name. |






<a name="easemesh.v1alpha1.IngressRule"></a>

### IngressRule
IngressRule is the rule for mesh ingress.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| host | [string](#string) |  | Host is the RFC3986 defined host name. |
| paths | [IngressPath](#easemesh.v1alpha1.IngressPath) | repeated | Paths is an array for mapping HTTP paths to mesh services. |






<a name="easemesh.v1alpha1.LoadBalance"></a>

### LoadBalance
LoadBalance configures how to distribute the traffic inside this mesh.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| policy | [string](#string) |  | Policy including four kinds of load balancing scheme, including random, weightedRandom,ipHash, headerHash |
| headerHashKey | [string](#string) |  | HeaderHashKey configures the key in HTTP header when the policy is headerHash. |






<a name="easemesh.v1alpha1.Mock"></a>

### Mock
Mock is the spec of mocking service&#39;s HTTP responses. Once enabled,
this service won&#39;t need to be deployed, and other services visit it will get
the configured response directly.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| enabled | [bool](#bool) |  | Enable configures this mesh service&#39;s mocking switch. |
| rules | [MockRule](#easemesh.v1alpha1.MockRule) | repeated | Rules are the array for this mocking service. |






<a name="easemesh.v1alpha1.MockRule"></a>

### MockRule
MockRule is one rule for mocking service.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| path | [string](#string) |  | Path is the exactly path for matching request. |
| pathPrefix | [string](#string) |  | PathPrefix is the prefix matching for request. |
| code | [int32](#int32) |  | Code is the HTTP response code. |
| headers | [MockRule.HeadersEntry](#easemesh.v1alpha1.MockRule.HeadersEntry) | repeated | Headers is the HTTP header fields for response. |
| body | [string](#string) |  | Bosy is the HTTP response body. |
| delay | [string](#string) |  | Delay is the waiting duration for HTTP reponse. |






<a name="easemesh.v1alpha1.MockRule.HeadersEntry"></a>

### MockRule.HeadersEntry



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  |  |
| value | [string](#string) |  |  |






<a name="easemesh.v1alpha1.Observability"></a>

### Observability
Observability consists of three components, outputServer, tracing, and metrics.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| outputServer | [ObservabilityOutputServer](#easemesh.v1alpha1.ObservabilityOutputServer) |  | OutputServer configures JavaAgent&#39;s tracing output target. |
| tracings | [ObservabilityTracings](#easemesh.v1alpha1.ObservabilityTracings) |  | Tracings configures whether JavaAgent should deal with tracing HTTP header or not. |
| metrics | [ObservabilityMetrics](#easemesh.v1alpha1.ObservabilityMetrics) |  | Metrics configures the metrics JavaAgent should collect. |






<a name="easemesh.v1alpha1.ObservabilityMetrics"></a>

### ObservabilityMetrics



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| enabled | [bool](#bool) |  | Enabled configures the global switch for this mesh service. |
| access | [ObservabilityMetricsDetail](#easemesh.v1alpha1.ObservabilityMetricsDetail) |  | Access configures the access log about metrics. |
| request | [ObservabilityMetricsDetail](#easemesh.v1alpha1.ObservabilityMetricsDetail) |  | Request configures this mesh service&#39;s HTTP APIs metrics. |
| jdbcStatement | [ObservabilityMetricsDetail](#easemesh.v1alpha1.ObservabilityMetricsDetail) |  | JdbcStatement configures this mesh service&#39;s JDBC statement metrics. |
| jdbcConnection | [ObservabilityMetricsDetail](#easemesh.v1alpha1.ObservabilityMetricsDetail) |  | JdbcConnection configures this mesh service&#39;s JDBC connection related metrics. |
| rabbit | [ObservabilityMetricsDetail](#easemesh.v1alpha1.ObservabilityMetricsDetail) |  | Rabbit configures this mesh service&#39;s RabbitMQ requesting metrics. |
| kafka | [ObservabilityMetricsDetail](#easemesh.v1alpha1.ObservabilityMetricsDetail) |  | Kafka configures this mesh service&#39;s Kafka requesting metrics. |
| redis | [ObservabilityMetricsDetail](#easemesh.v1alpha1.ObservabilityMetricsDetail) |  | Redis configures this mesh service&#39;s redis requesting metrics. |
| jvmGc | [ObservabilityMetricsDetail](#easemesh.v1alpha1.ObservabilityMetricsDetail) |  | JvmGc configures this mesh service&#39;s JVM GC related metrics. |
| jvmMemory | [ObservabilityMetricsDetail](#easemesh.v1alpha1.ObservabilityMetricsDetail) |  | JvmMemory configures this mesh service&#39;s JVM memory usage related metrics. |
| md5Dictionary | [ObservabilityMetricsDetail](#easemesh.v1alpha1.ObservabilityMetricsDetail) |  | Md5Dictionary configures this service&#39;s md5Dictionary for reporting complete SQL Sentence and signature. |






<a name="easemesh.v1alpha1.ObservabilityMetricsDetail"></a>

### ObservabilityMetricsDetail
ObservabilityMetricsDetail is the metrics detail of observability.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| enabled | [bool](#bool) |  | Enabled configures the switch for one kind metric. |
| interval | [int32](#int32) |  | Interval configures the million seconds for metric reporting. |
| topic | [string](#string) |  | Topic configures the metrics&#39; reporting Kafka topic. |






<a name="easemesh.v1alpha1.ObservabilityOutputServer"></a>

### ObservabilityOutputServer
ObservabilityOutputServer configures how to report observability data to Kafka.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| enabled | [bool](#bool) |  | Enabled configures whether reporting observability data to Kafka or not. |
| bootstrapServer | [string](#string) |  | BootstrapServer configures the Kafka bootstrap servers. |
| timeout | [int32](#int32) |  | Timeout configures the timeout million second for requesting Kafka. |






<a name="easemesh.v1alpha1.ObservabilityTracings"></a>

### ObservabilityTracings
ObservabilityTracings configure the tracings of observability.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| enabled | [bool](#bool) |  | Enable configures this mesh service&#39;s global tracing switch. |
| sampleByQPS | [int32](#int32) |  | SampleByQPS configures the QPS value for tracing sampling. The exceeded request will be ignored. |
| output | [ObservabilityTracingsOutputConfig](#easemesh.v1alpha1.ObservabilityTracingsOutputConfig) |  | Output configures the tracing output topic, queue and thread. |
| request | [ObservabilityTracingsDetail](#easemesh.v1alpha1.ObservabilityTracingsDetail) |  | Request configures the tracing switch for this mesh service&#39;s HTTP APIs. |
| remoteInvoke | [ObservabilityTracingsDetail](#easemesh.v1alpha1.ObservabilityTracingsDetail) |  | RemoteInvoke configures the tracing switch for this mesh service&#39;s HTTP RPC tracing. |
| kafka | [ObservabilityTracingsDetail](#easemesh.v1alpha1.ObservabilityTracingsDetail) |  | Kafka configures the tracing switch for this mesh service&#39;s Kafka requesting. |
| jdbc | [ObservabilityTracingsDetail](#easemesh.v1alpha1.ObservabilityTracingsDetail) |  | Jdbc configures the tracing switch for this mesh service&#39;s JDBC requesting. |
| redis | [ObservabilityTracingsDetail](#easemesh.v1alpha1.ObservabilityTracingsDetail) |  | Redis configures the tracing switch for this mesh service&#39;s redis requesting. |
| rabbit | [ObservabilityTracingsDetail](#easemesh.v1alpha1.ObservabilityTracingsDetail) |  | Rabbit configures the tracing switch for this mesh service&#39;s rabbitMQ requesting. |






<a name="easemesh.v1alpha1.ObservabilityTracingsDetail"></a>

### ObservabilityTracingsDetail
ObservabilityTracingsDetail


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| enabled | [bool](#bool) |  | Enabled configures whether reporting this tracing component or not. |
| servicePrefix | [string](#string) |  | ServicePrefix is used to be combined with the tracing component&#39;s. |






<a name="easemesh.v1alpha1.ObservabilityTracingsOutputConfig"></a>

### ObservabilityTracingsOutputConfig



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| enabled | [bool](#bool) |  | Enabled configures whether reporting to tracing output or not. |
| reportThread | [int32](#int32) |  | ReportThread configures the thread number for JavaAgent&#39;s reporting process. |
| topic | [string](#string) |  | Topic configures the Kafka topic for tracing output target. |
| messageMaxBytes | [int32](#int32) |  | MessageMaxBytes configures the max bytes for one tracing report message. |
| queuedMaxSpans | [int32](#int32) |  | QueuedMaxSpans configures the max spans number for reporting queued. |
| queuedMaxSize | [int32](#int32) |  | QueuedMaxSize configures the max size of reporting queue. |
| messageTimeout | [int32](#int32) |  | MessageTimeout configures the timeout for the message queue. |






<a name="easemesh.v1alpha1.RateLimiter"></a>

### RateLimiter
RateLimiter configures a limiter which can establish your services&#39; high availability and reliability,
also it can be used for scaling APIs. RateLimiter can protect servers from overwhelm by the peak traffic.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| policies | [RateLimiterPolicy](#easemesh.v1alpha1.RateLimiterPolicy) | repeated | Policies contains different limiting configurations for this RateLimiter to use. |
| defaultPolicyRef | [string](#string) |  | DefaultPolicyRef is the default reference policy name. |
| urls | [URLRule](#easemesh.v1alpha1.URLRule) | repeated | Urls describe the HTTP request matching schemes for this limiter to filter. |






<a name="easemesh.v1alpha1.RateLimiterPolicy"></a>

### RateLimiterPolicy
RateLimiterPolicy configures the limiting policy used for Resilience component RateLimiter.
It contains the basic configurations for the limiter, including the permission number,
the duration for request waiting and the permission count refreshing period.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | Name is the identify of this policy. |
| timeoutDuration | [string](#string) |  | TimeoutDuration is the duration for one request should wait for a permission,e.g.,500ms. |
| limitRefreshPeriod | [string](#string) |  | LimitRefreshPeriod is the period of a limit refresh. After each period the rate limiter sets its permissions count back to the limitForPeriod value. |
| limitForPeriod | [int32](#int32) |  | LimitForPeriod is the number of permissions available during one limit refresh period. |






<a name="easemesh.v1alpha1.Resilience"></a>

### Resilience
Resilience configures four key types of features, RateLimiter, CircuitBreaker,
Retryer and Timeout.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| rateLimiter | [RateLimiter](#easemesh.v1alpha1.RateLimiter) |  | RateLimiter configuration. |
| circuitBreaker | [CircuitBreaker](#easemesh.v1alpha1.CircuitBreaker) |  | CircuitBreaker configuration. |
| retryer | [Retryer](#easemesh.v1alpha1.Retryer) |  | Retryer configuration. |
| timeLimiter | [TimeLimiter](#easemesh.v1alpha1.TimeLimiter) |  | TimeLimiter configuration |






<a name="easemesh.v1alpha1.Retryer"></a>

### Retryer
Retryer can perform an API calling retry when the service HTTP response code indicated its in
temporary unavailable states. The up-stream client should make sure this API is idempotent.
The service can declare an Retryer for its desired APIs and active in client side.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| policies | [RetryerPolicy](#easemesh.v1alpha1.RetryerPolicy) | repeated | Policies contain different retryer configurations for this Retryer to use. |
| defaultPolicyRef | [string](#string) |  | DefaultPolicyRef is the default reference policy name. |
| urls | [URLRule](#easemesh.v1alpha1.URLRule) | repeated | Urls describe the HTTP request matching schemes for this limiter to filter. |






<a name="easemesh.v1alpha1.RetryerPolicy"></a>

### RetryerPolicy
RetryerPolicy configures the policy for describing Resilience component Retryer.
It contains the basic configurations for the retryer, including the type of sliding window this
breaker will use. Whether including network error or not and so on.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | Name is the identify of this policy. |
| maxAttempts | [int32](#int32) |  | MaxAttempts configures the maximum number of attempts. (including the initial call as the first attempt) |
| waitDuration | [string](#string) |  | WaitDuration configures the based and fixed wait duration between retry attempts. |
| backOffPolicy | [string](#string) |  | BackOffPolicy configures the two kinds of policy, random and exponential. |
| randomizationFactor | [double](#double) |  | RandomizationFactor configures the factor used for backoff, value between 0 and 1. |
| countingNetworkError | [bool](#bool) |  | CountingNetworkError configures whether a network failure situation should retry or not. |
| failureStatusCodes | [int32](#int32) | repeated | FailureStatusCodes is the array for HTTP failure status code for this RetryPolicy. |






<a name="easemesh.v1alpha1.Service"></a>

### Service
Service is the basic element in EaseMesh to describe a user&#39;s business microservices&#39;
name, belonging tenant, and governance specs. One service should belongs to a dedicated
tenant.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | Name is the mesh service&#39;s name. |
| registerTenant | [string](#string) |  | RegisterTenant is the tenant&#39;s name this service belongs to. |
| resilience | [Resilience](#easemesh.v1alpha1.Resilience) |  | Resilience configuration, optional. |
| canary | [Canary](#easemesh.v1alpha1.Canary) |  | Canary configuration, optional. |
| loadBalance | [LoadBalance](#easemesh.v1alpha1.LoadBalance) |  | LoadBalance configuration, optional. |
| sidecar | [Sidecar](#easemesh.v1alpha1.Sidecar) |  | Sidecar configuration, optional. |
| observability | [Observability](#easemesh.v1alpha1.Observability) |  | Observability configuration, optional. |
| mock | [Mock](#easemesh.v1alpha1.Mock) |  | Mock configuration, optional. |






<a name="easemesh.v1alpha1.ServiceInstance"></a>

### ServiceInstance
ServiceInstance is the runnable entity of a Mesh Service.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| registryName | [string](#string) |  | registryName is the name of registry. |
| serviceName | [string](#string) |  | ServiceName is the name of service this instance belongs to. |
| instanceID | [string](#string) |  | InstanceID is the identity of this instance. |
| ip | [string](#string) |  | IP is this instance&#39;s address in EaseMesh. |
| port | [int32](#int32) |  | Port is the port this instance listening to. |
| registryTime | [string](#string) |  | RegistryTime is the time this instance registered. |
| labels | [ServiceInstance.LabelsEntry](#easemesh.v1alpha1.ServiceInstance.LabelsEntry) | repeated | Labels is a map for storing service labels. This field is used for Canary Deployment. |
| status | [string](#string) |  | Status is the status of this mesh service instance. |






<a name="easemesh.v1alpha1.ServiceInstance.LabelsEntry"></a>

### ServiceInstance.LabelsEntry



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  |  |
| value | [string](#string) |  |  |






<a name="easemesh.v1alpha1.Sidecar"></a>

### Sidecar
Sidecar configures the sidecar for every mesh service instances. It works inside the same
pod with the workload instance.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| discoveryType | [string](#string) |  | DiscoveryType configures the type of service register/discovery type, its value are among &#34;eureka&#34;,&#34;consul&#34;, and &#34;nacos&#34;. |
| address | [string](#string) |  | Address is the registry center address for workload to visit. |
| ingressPort | [int32](#int32) |  | IngressPort is the port for ingress traffic. |
| ingressProtocol | [string](#string) |  | IngressProtocol is the protocol for ingress traffic. Its value is &#34;http&#34;. |
| egressPort | [int32](#int32) |  | EgressPort is the port for egress traffic. |
| egressProtocol | [string](#string) |  | EgressProtocol is the protocol for egress traffic. Its value is &#34;http&#34; |






<a name="easemesh.v1alpha1.StringMatch"></a>

### StringMatch
StringMatch configures how to match string in different ways.
Its priority is according to the field order. StringMatch will try exactly matching firstly,
then try to check has the same prefix, at last, it will use the regular expression to match the
string if it&#39;s provided


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| exact | [string](#string) |  | Exact configures the exactly URL value to match. |
| prefix | [string](#string) |  | Prefix configures the prefix for URL to match. |
| regex | [string](#string) |  | Regex configures the regular expression for URL to match. |






<a name="easemesh.v1alpha1.Tenant"></a>

### Tenant
Tenant is the logic group of mesh services. Inside the same tenant,
services can visit each other directly. There are two kinds of tenant, one is the  common type
of tenants and the other is system reserved &#34;global&#34; tenant which&#39;s access scope is globally
inside the mesh . If one mesh service is created with &#34;global&#34; tenant filed, it can be visible
to all the service inside the mesh.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | Name is the identify of this tenant. |
| services | [string](#string) | repeated | Services are the array of mesh service name in this tenant. |
| description | [string](#string) |  | Descriptions for this tenant. |






<a name="easemesh.v1alpha1.TimeLimiter"></a>

### TimeLimiter
Timeout configures the amount of time the client should wait for replies from a given service,
it will be running in upstream clients and declared in downstream relied services.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| defaultTimeoutDuration | [string](#string) |  | DefaultTimeoutDuration configures the default duration for timeout, e.g.,500ms. |
| urls | [URLRule](#easemesh.v1alpha1.URLRule) | repeated | Urls describe the HTTP request matching schemes for this limiter to filter. |






<a name="easemesh.v1alpha1.TrafficTarget"></a>

### TrafficTarget
TrafficTarget is the specification of a TrafficTarget.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | Name is the name for referencing a TrafficTarget. |
| destination | [IdentityBindingSubject](#easemesh.v1alpha1.IdentityBindingSubject) |  | Destination is the service to allow ingress traffic. |
| sources | [IdentityBindingSubject](#easemesh.v1alpha1.IdentityBindingSubject) | repeated | Sources are the services to allow egress traffic. |
| rules | [TrafficTargetRule](#easemesh.v1alpha1.TrafficTargetRule) | repeated | Rules are the traffic rules to allow (HTTPRoutes). |






<a name="easemesh.v1alpha1.TrafficTargetRule"></a>

### TrafficTargetRule
TrafficTargetRule is the TrafficSpec to allow for a TrafficTarget,
TrafficSpec can only be HTTPRouteGroup by now.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| kind | [string](#string) |  | Kind is the kind of TrafficSpec to allow, must be &#34;HTTPRouteGroup&#34; by now. |
| name | [string](#string) |  | Name of the TrafficSpec to use. |
| matches | [string](#string) | repeated | Matches is a list of TrafficSpec routes to allow traffic for, TrafficSpec routes can only be HTTPMatch by now. |






<a name="easemesh.v1alpha1.URLRule"></a>

### URLRule
URLRule can be used to filter HTTP request by using HTTP method and URL.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| methods | [string](#string) | repeated | Methods configures allowed HTTP method string, e.g. &#34;GET&#34;,&#34;DELETE&#34;,&#34;POST&#34;. |
| url | [StringMatch](#easemesh.v1alpha1.StringMatch) |  | Url configures how to match the HTTP request URL. |
| policyRef | [string](#string) |  | PolicyRef configures which policy this URLRule references to. |





 

 

 

 



## Scalar Value Types

| .proto Type | Notes | C++ | Java | Python | Go | C# | PHP | Ruby |
| ----------- | ----- | --- | ---- | ------ | -- | -- | --- | ---- |
| <a name="double" /> double |  | double | double | float | float64 | double | float | Float |
| <a name="float" /> float |  | float | float | float | float32 | float | float | Float |
| <a name="int32" /> int32 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="int64" /> int64 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="uint32" /> uint32 | Uses variable-length encoding. | uint32 | int | int/long | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="uint64" /> uint64 | Uses variable-length encoding. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum or Fixnum (as required) |
| <a name="sint32" /> sint32 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sint64" /> sint64 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="fixed32" /> fixed32 | Always four bytes. More efficient than uint32 if values are often greater than 2^28. | uint32 | int | int | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="fixed64" /> fixed64 | Always eight bytes. More efficient than uint64 if values are often greater than 2^56. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum |
| <a name="sfixed32" /> sfixed32 | Always four bytes. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sfixed64" /> sfixed64 | Always eight bytes. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="bool" /> bool |  | bool | boolean | boolean | bool | bool | boolean | TrueClass/FalseClass |
| <a name="string" /> string | A string must always contain UTF-8 encoded or 7-bit ASCII text. | string | String | str/unicode | string | string | string | String (UTF-8) |
| <a name="bytes" /> bytes | May contain any arbitrary sequence of bytes. | string | ByteString | str | []byte | ByteString | string | String (ASCII-8BIT) |

