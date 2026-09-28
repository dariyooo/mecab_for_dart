#ifndef MECAB_CONFIG_H
#define MECAB_CONFIG_H

/* --- Package Information --- */
#define PACKAGE "mecab"
#define VERSION "0.996"
#define DIC_VERSION 102

/* --- Windows (MSVC) Specific Configuration --- */
#if defined(_WIN32) || defined(_WIN64)
    #define HAVE_WINDOWS_H 1
    #define HAVE_GETENV 1
    #define MECAB_USE_THREAD 1
    #define DLL_EXPORT 1
    
    /* Standard Windows paths for mecabrc */
    #ifndef MECAB_DEFAULT_RC
        #define MECAB_DEFAULT_RC "mecabrc"
    #endif

    /* Security fixes for MSVC */
    #define _CRT_SECURE_NO_DEPRECATE 1
    #define _CRT_SECURE_NO_WARNINGS

/* --- Unix/Android/iOS (GCC/Clang) Specific Configuration --- */
#else
    #define HAVE_DIRENT_H 1
    #define HAVE_UNISTD_H 1
    #define HAVE_FCNTL_H 1
    #define HAVE_SYS_STAT_H 1
    #define HAVE_SYS_MMAN_H 1
    #define HAVE_MMAP 1
    #define HAVE_GETENV 1
    #define MECAB_USE_THREAD 1
    
    #ifndef MECAB_DEFAULT_RC
        #define MECAB_DEFAULT_RC "mecabrc"
    #endif

#endif

/* --- Common Headers (Found on almost all modern platforms) --- */
#define HAVE_STDINT_H 1
#define HAVE_STRING_H 1
#define STDC_HEADERS 1

#endif /* MECAB_CONFIG_H */