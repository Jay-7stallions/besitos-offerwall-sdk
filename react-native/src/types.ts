export interface OfferwallConfig {
  partnerId: string;
  userId: string;
  subId?: string;
  deviceId?: string;
  idfa?: string;
  gdfa?: string;
  info?: string;
  hideHeader?: boolean;
  hideFooter?: boolean;
  apiVersion?: string;
}

export interface OfferwallError {
  errorCode: number;
  description: string;
}
