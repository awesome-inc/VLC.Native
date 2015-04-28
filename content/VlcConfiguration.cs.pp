using System;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Runtime.InteropServices;
using LibVlcWrapper;
using Microsoft.Win32;

namespace $rootnamespace$
{
    /// <summary>
    /// Configuration class for VLC native dependencies
    /// </summary>
    public static partial class VlcConfiguration
    {
        private static string _libVlcVersion;

        public static string LibVlcVersion
        {
            get
            {
                if (_libVlcVersion != null) return _libVlcVersion;
                var pStr = LibVlcMethods.libvlc_get_version();
                _libVlcVersion = Marshal.PtrToStringAnsi(pStr);
                return _libVlcVersion;
            }
        }

        public static bool IsVlcPresent { get; private set; }

        public static void VerifyVlcPresent()
        {
            if (!IsVlcPresent) 
                throw new InvalidOperationException("Cannot find VLC directory.");
        }

        static VlcConfiguration()
        {
            var homePath = GetHomePath();
            var vlcPath = Path.Combine(homePath, "vlc");
            var nativePath = Path.Combine(vlcPath, GetPlatform());

            IsVlcPresent = Directory.Exists(nativePath);
            if (!IsVlcPresent)
            {
                Trace.TraceWarning("Cannot find VLC directory.");
                return;
            }

            // Prepend native path to environment path, to ensure the right libs are being used.
            var path = Environment.GetEnvironmentVariable("PATH");
            path = String.Concat(nativePath, ";", path);
            Environment.SetEnvironmentVariable("PATH", path);

            Trace.TraceInformation("Using VLC {0} {1} from {2}", 
                LibVlcVersion, Environment.Is64BitProcess ? "x64" : "x86", nativePath);
        }

        private static string GetHomePath()
        {
            // TODO: add your lookup path which contains ".\vlc\**.*"
            var homePath = GetSafeEnv("<your home>");
            if (String.IsNullOrWhiteSpace(homePath))
            {
                var executingAssemblyFile = new Uri(Assembly.GetEntryAssembly().GetName().CodeBase).LocalPath;
                homePath = Path.GetDirectoryName(executingAssemblyFile);
            }
            return homePath;
        }

        private static string GetPlatform() { return Environment.Is64BitProcess ? "x64" : "x86"; }

        private const string UserEnvRegKey = @"HKEY_CURRENT_USER\Environment";
        private const string SystemEnvRegKey = @"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment";

        private static string GetSafeEnv(string envVar)
        {
            var value = Environment.GetEnvironmentVariable(envVar);
            if (String.IsNullOrWhiteSpace(value))
            {
                value = (String)Registry.GetValue(UserEnvRegKey, envVar, null);
                if (String.IsNullOrWhiteSpace(value))
                    value = (String)Registry.GetValue(SystemEnvRegKey, envVar, null);
            }
            return value ?? String.Empty;
        }
    }
}