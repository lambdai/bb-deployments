local common = import 'common.libsonnet';

{
  blobstore: common.blobstore,
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
  scheduler: { address: 'scheduler:8983' },
  maximumMemoryCachedDirectories: 1000,
  instanceName: 'remote-execution',
  buildDirectories: [{
    native: {
      buildDirectoryPath: '/worker/build',
      cacheDirectoryPath: '/worker/cache',
      maximumCacheFileCount: 10000,
      maximumCacheSizeBytes: 1024 * 1024 * 1024,
      cacheReplacementPolicy: 'LEAST_RECENTLY_USED',
    },
    runners: [
     {
      endpoint: { address: 'unix:///worker/runner' },
      concurrency: 43,
      platform: {
        properties: [
          { name: 'OSFamily', value: 'Linux' },
	  { name: 'container-image', value: 'docker://gcr.io/envoy-ci/envoy-build@sha256:566c2488fb30d7a8bbe8f96a238c924362d807a03b8e58b9db0970ce30b6e9a1' },
	  {"name":"dockerAddCapabilities","value":"SYS_PTRACE,NET_RAW,NET_ADMIN"},
	  {"name":"dockerNetwork","value":"standard"},
          {"name":"label:size","value":"large"},
        ],
      },
      defaultExecutionTimeout: '1800s',
      maximumExecutionTimeout: '3600s',
      workerId: {
        datacenter: 'paris',
        rack: '4',
        slot: '15',
        hostname: 'ubuntu-worker-l.example.com',
      },
    },
     {
      endpoint: { address: 'unix:///worker/runner' },
      concurrency: 37,
      platform: {
        properties: [
          { name: 'OSFamily', value: 'Linux' },
	  { name: 'container-image', value: 'docker://gcr.io/envoy-ci/envoy-build@sha256:566c2488fb30d7a8bbe8f96a238c924362d807a03b8e58b9db0970ce30b6e9a1' },
	  {"name":"dockerAddCapabilities","value":"SYS_PTRACE,NET_RAW,NET_ADMIN"},
	  {"name":"dockerNetwork","value":"standard"},
        ],
      },
      defaultExecutionTimeout: '1800s',
      maximumExecutionTimeout: '3600s',
      workerId: {
        datacenter: 'paris',
        rack: '4',
        slot: '15',
        hostname: 'ubuntu-worker.example.com',
      },
    },
],
  }],
}
