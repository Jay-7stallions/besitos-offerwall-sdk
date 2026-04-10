import React, {
  createContext,
  useContext,
  useEffect,
  useRef,
  useState,
} from 'react';
import {
  StyleSheet,
  View,
  TouchableOpacity,
  Text,
} from 'react-native';
import { WebView, WebViewNavigation } from 'react-native-webview';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { BesitosOfferwall } from './BesitosOfferwall';
import { OfferwallConfig, OfferwallError } from './types';

const TRUSTED_HOST = 'wall.besitos.ai';

interface OfferwallContextValue {
  url: string | null;
  isLoading: boolean;
  setIsLoading: (v: boolean) => void;
  error: OfferwallError | null;
  onClose: () => void;
  onRetry: () => void;
}

const OfferwallContext = createContext<OfferwallContextValue | null>(null);

function useOfferwallContext() {
  const ctx = useContext(OfferwallContext);
  if (!ctx) throw new Error('Offerwall compound components must be used inside <Offerwall.Root>');
  return ctx;
}

interface RootProps {
  config: OfferwallConfig;
  onFullClose: () => void;
  children: React.ReactNode;
}

function Root({ config, onFullClose, children }: RootProps) {
  const insets = useSafeAreaInsets();
  const [url, setUrl] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<OfferwallError | null>(null);
  const retryKey = useRef(0);

  useEffect(() => {
    const validation = BesitosOfferwall.validate(config);
    if (!validation.valid) {
      setError({ errorCode: 400, description: validation.reason ?? 'Invalid configuration' });
      setIsLoading(false);
      return;
    }

    const sdk = new BesitosOfferwall(config);
    sdk.buildUrl().then((builtUrl) => {
      setUrl(builtUrl);
      setError(null);
    });
  }, [config, retryKey.current]);

  const onRetry = () => {
    setError(null);
    setIsLoading(true);
    retryKey.current += 1;
    const sdk = new BesitosOfferwall(config);
    sdk.buildUrl().then(setUrl);
  };

  return (
    <OfferwallContext.Provider
      value={{ url, isLoading, setIsLoading, error, onClose: onFullClose, onRetry }}
    >
      <View
        style={[
          styles.root,
          {
            paddingTop: insets.top,
            paddingBottom: insets.bottom,
            paddingLeft: insets.left,
            paddingRight: insets.right,
          },
        ]}
      >
        {children}
      </View>
    </OfferwallContext.Provider>
  );
}

function Content() {
  const { url, error, setIsLoading, onClose } = useOfferwallContext();

  const handleNavigationStateChange = (state: WebViewNavigation) => {
    if (!state.url) return;
    try {
      const host = new URL(state.url).hostname;
      if (host !== TRUSTED_HOST) {
        onClose();
      }
    } catch {}
  };

  if (error || !url) return null;

  return (
    <WebView
      source={{ uri: url }}
      style={styles.webview}
      javaScriptEnabled
      domStorageEnabled
      thirdPartyCookiesEnabled
      sharedCookiesEnabled
      onLoadStart={() => setIsLoading(true)}
      onLoadEnd={() => setIsLoading(false)}
      onNavigationStateChange={handleNavigationStateChange}
    />
  );
}

interface LoaderProps {
  children: React.ReactNode;
}

function Loader({ children }: LoaderProps) {
  const { isLoading, error } = useOfferwallContext();
  if (!isLoading || error) return null;
  return <>{children}</>;
}

interface ErrorProps {
  children: (err: OfferwallError) => React.ReactNode;
}

function ErrorSlot({ children }: ErrorProps) {
  const { error } = useOfferwallContext();
  if (!error) return null;
  return <>{children(error)}</>;
}

interface CloseButtonProps {
  children?: React.ReactNode;
}

function CloseButton({ children }: CloseButtonProps) {
  const insets = useSafeAreaInsets();
  const { onClose } = useOfferwallContext();
  return (
    <TouchableOpacity 
      style={[
        styles.closeButton, 
        { 
          top: Math.max(insets.top, 12),
          right: Math.max(insets.right, 12)
        }
      ]} 
      onPress={onClose} 
      accessibilityLabel="Close offerwall"
    >
      {children ?? <Text style={styles.closeText}>✕</Text>}
    </TouchableOpacity>
  );
}

export const Offerwall = {
  Root,
  Content,
  Loader,
  Error: ErrorSlot,
  CloseButton,
};

const styles = StyleSheet.create({
  root: {
    flex: 1,
    backgroundColor: '#FFFFFF',
  },
  webview: {
    flex: 1,
  },
  closeButton: {
    position: 'absolute',
    top: 12,
    right: 12,
    zIndex: 100,
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: 'rgba(255,255,255,0.85)',
    alignItems: 'center',
    justifyContent: 'center',
  },
  closeText: {
    fontSize: 16,
    color: '#1A1A1A',
    fontWeight: 'bold',
  },
});
