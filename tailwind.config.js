/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{rs,html}",
  ],
  theme: {
    extend: {
      fontFamily: {
        'mv-skifer': ['MV-SKIFER', 'sans-serif'],
        'onest': ['Onest', 'sans-serif'],
      },
      colors: {
        primary: '#04061B',
        secondary: '#3624A6',
      },
      animation: {
        'spin-slow': 'spin 3s linear infinite',
        'pulse-slow': 'pulse 3s ease-in-out infinite',
        'modal-backdrop-enter': 'modal-backdrop-enter 0.3s ease-out forwards',
        'modal-backdrop-exit': 'modal-backdrop-exit 0.2s ease-in forwards',
        'modal-content-enter': 'modal-content-enter 0.3s cubic-bezier(0.34, 1.56, 0.64, 1) forwards',
        'modal-content-exit': 'modal-content-exit 0.2s ease-in forwards',
        'skeleton-shimmer': 'skeleton-shimmer 1.5s infinite',
        'loading-pulse': 'loading-pulse 2s ease-in-out infinite',
        'fade-in': 'fadeIn 0.3s ease-out forwards',
        'fade-out': 'fadeOut 0.2s ease-in forwards',
      },
      keyframes: {
        'modal-backdrop-enter': {
          'from': {
            opacity: '0',
            'backdrop-filter': 'blur(0px)',
          },
          'to': {
            opacity: '1',
            'backdrop-filter': 'blur(8px)',
          },
        },
        'modal-backdrop-exit': {
          'from': {
            opacity: '1',
            'backdrop-filter': 'blur(8px)',
          },
          'to': {
            opacity: '0',
            'backdrop-filter': 'blur(0px)',
          },
        },
        'modal-content-enter': {
          'from': {
            opacity: '0',
            transform: 'scale(0.9) translateY(20px)',
          },
          'to': {
            opacity: '1',
            transform: 'scale(1) translateY(0)',
          },
        },
        'modal-content-exit': {
          'from': {
            opacity: '1',
            transform: 'scale(1) translateY(0)',
          },
          'to': {
            opacity: '0',
            transform: 'scale(0.95) translateY(-10px)',
          },
        },
        'skeleton-shimmer': {
          '0%': {
            'background-position': '-200px 0',
          },
          '100%': {
            'background-position': 'calc(200px + 100%) 0',
          },
        },
        'loading-pulse': {
          '0%, 100%': {
            opacity: '0.4',
            transform: 'scale(1)',
          },
          '50%': {
            opacity: '0.8',
            transform: 'scale(1.02)',
          },
        },
        'fadeIn': {
          'from': { opacity: '0' },
          'to': { opacity: '1' },
        },
        'fadeOut': {
          'from': { opacity: '1' },
          'to': { opacity: '0' },
        },
      },
      transitionTimingFunction: {
        'modal': 'cubic-bezier(0.34, 1.56, 0.64, 1)',
        'slide': 'cubic-bezier(0.4, 0, 0.2, 1)',
      },
      transitionDuration: {
        '400': '400ms',
        '600': '600ms',
      },
    },
  },
  plugins: [],
};
