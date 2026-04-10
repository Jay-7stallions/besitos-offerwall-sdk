import { OfferwallConfig } from './types';

const BASE = 'https://wall.besitos.ai';
const SAFE_PATTERN = /^[A-Za-z0-9\-_]*$/;

export class BesitosOfferwall {
  private config: OfferwallConfig;

  constructor(config: OfferwallConfig) {
    this.config = config;
  }

  async buildUrl(): Promise<string> {
    const { config } = this;
    const version = config.apiVersion ?? 'v1';
    const params = new URLSearchParams();

    params.set('userid', config.userId);

    if (config.subId?.trim()) params.set('subid', config.subId.trim());
    if (config.deviceId?.trim()) params.set('device_id', config.deviceId.trim());
    if (config.idfa?.trim()) params.set('idfa', config.idfa.trim());
    if (config.gdfa?.trim()) params.set('gdfa', config.gdfa.trim());
    if (config.info?.trim()) params.set('info', config.info.trim());
    if (config.hideHeader) params.set('hide_header', '1');
    if (config.hideFooter) params.set('hide_footer', '1');

    return `${BASE}/${version}/${encodeURIComponent(config.partnerId)}/offers?${params.toString()}`;
  }

  static validate(config: OfferwallConfig): { valid: boolean; reason?: string } {
    if (!config.partnerId?.trim()) {
      return { valid: false, reason: 'partnerId is required' };
    }
    if (!SAFE_PATTERN.test(config.partnerId)) {
      return { valid: false, reason: 'partnerId contains invalid characters' };
    }
    if (!config.userId?.trim()) {
      return { valid: false, reason: 'userId is required' };
    }
    if (!SAFE_PATTERN.test(config.userId)) {
      return { valid: false, reason: 'userId contains invalid characters' };
    }
    return { valid: true };
  }
}
