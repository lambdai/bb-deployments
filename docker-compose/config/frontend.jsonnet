local common = import 'common.libsonnet';

{
  blobstore: common.blobstore,
  grpcServers: [{
    listenAddresses: [':8980'],
    authenticationPolicy: { allow: {} },
  }],
  schedulers: {
    '': { endpoint: { address: 'scheduler:8982' } },
  },
  global: {
    diagnosticsHttpListenAddress: ":7982",
  },
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
}
