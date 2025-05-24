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
      /* Modern Animation System */
      transitionDuration: {
        'short1': '50ms',
        'short2': '100ms',
        'short3': '150ms',
        'short4': '200ms',
        'medium1': '250ms',
        'medium2': '300ms',
        'medium3': '350ms',
        'medium4': '400ms',
        'long1': '450ms',
        'long2': '500ms',
        'long3': '550ms',
        'long4': '600ms',
      },
      transitionTimingFunction: {
        'standard': 'cubic-bezier(0.2, 0.0, 0, 1)',
        'emphasized': 'cubic-bezier(0.05, 0.7, 0.1, 1)',
        'emphasized-decelerate': 'cubic-bezier(0.3, 0.0, 0.8, 0.15)',
        'emphasized-accelerate': 'cubic-bezier(0.3, 0.0, 0.8, 0.15)',
        'legacy': 'cubic-bezier(0.4, 0.0, 0.2, 1)',
      },
      animation: {
        'spin-slow': 'spin 3s linear infinite',
        'pulse-slow': 'pulse 3s ease-in-out infinite',
        'shimmer': 'shimmer 2s infinite cubic-bezier(0.2, 0.0, 0, 1)',
        'fade-in': 'fadeIn 300ms cubic-bezier(0.2, 0.0, 0, 1)',
        'slide-up': 'slideUp 300ms cubic-bezier(0.05, 0.7, 0.1, 1)',
        'slide-down': 'slideDown 300ms cubic-bezier(0.05, 0.7, 0.1, 1)',
        'scale-in': 'scaleIn 250ms cubic-bezier(0.05, 0.7, 0.1, 1)',
      },
      keyframes: {
        shimmer: {
          '0%': { transform: 'translateX(-100%)' },
          '100%': { transform: 'translateX(100%)' },
        },
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
        slideUp: {
          '0%': { transform: 'translateY(12px)', opacity: '0' },
          '100%': { transform: 'translateY(0)', opacity: '1' },
        },
        slideDown: {
          '0%': { transform: 'translateY(-12px)', opacity: '0' },
          '100%': { transform: 'translateY(0)', opacity: '1' },
        },
        scaleIn: {
          '0%': { transform: 'scale(0.94)', opacity: '0' },
          '100%': { transform: 'scale(1)', opacity: '1' },
        },
      },
    },
  },
  plugins: [],
};
