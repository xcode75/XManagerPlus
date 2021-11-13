
<!DOCTYPE html>
<html lang="en" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">

  <head>
    <meta charset="utf-8">
    <meta name="x-apple-disable-message-reformatting">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="format-detection" content="telephone=no, date=no, address=no, email=no">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,200;1,300;1,400;1,500;1,600;1,700" rel="stylesheet" media="screen">
    <style>
      .hover-underline:hover {
        text-decoration: underline !important;
      }

      @keyframes spin {
        to {
          transform: rotate(360deg);
        }
      }

      @keyframes ping {

        75%,
        100% {
          transform: scale(2);
          opacity: 0;
        }
      }

      @keyframes pulse {
        50% {
          opacity: .5;
        }
      }

      @keyframes bounce {

        0%,
        100% {
          transform: translateY(-25%);
          animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
        }

        50% {
          transform: none;
          animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
        }
      }

      @media (max-width: 600px) {
        .sm-leading-32 {
          line-height: 32px !important;
        }

        .sm-px-24 {
          padding-left: 24px !important;
          padding-right: 24px !important;
        }

        .sm-py-32 {
          padding-top: 32px !important;
          padding-bottom: 32px !important;
        }

        .sm-w-full {
          width: 100% !important;
        }
      }
    </style>
  </head>

  <body style="margin: 0; padding: 0; width: 100%; word-break: break-word; -webkit-font-smoothing: antialiased; --bg-opacity: 1; background-color: #eceff1; background-color: rgba(236, 239, 241, var(--bg-opacity));">
    
    <div role="article" aria-roledescription="email" aria-label="" >
      <table style="font-family: Montserrat, -apple-system, 'Segoe UI', sans-serif; width: 100%;" width="100%" cellpadding="0" cellspacing="0" role="presentation">
        <tr>
          <td align="center" style="--bg-opacity: 1; background-color: #ffffff; background-color: #ffffff; font-family: Montserrat, -apple-system, 'Segoe UI', sans-serif;" bgcolor="rgba(236, 239, 241, var(--bg-opacity))">
            <table class="sm-w-full" style="font-family: 'Montserrat',Arial,sans-serif; width: 600px;" width="600" cellpadding="0" cellspacing="0" role="presentation">
              <tr>
                <td align="center" class="sm-px-24" style="font-family: 'Montserrat',Arial,sans-serif;">
                  <table style="font-family: 'Montserrat',Arial,sans-serif; width: 100%;" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                    <tr>
                      <td class="sm-px-24" style="--bg-opacity: 1; background-color: #ffffff; background-color: rgba(255, 255, 255, var(--bg-opacity)); border-radius: 4px; font-family: Montserrat, -apple-system, 'Segoe UI', sans-serif; font-size: 14px; line-height: 24px; padding: 48px; text-align: left; --text-opacity: 1; color: #626262; color: rgba(98, 98, 98, var(--text-opacity));" bgcolor="rgba(255, 255, 255, var(--bg-opacity))" align="left">
                        <p style="font-weight: 600; font-size: 18px; margin-bottom: 0;">{$lang->get('Hello')}</p>
                        <p style="font-weight: 700; font-size: 20px; margin-top: 0; --text-opacity: 1; color: #ff5850; color: rgba(255, 88, 80, var(--text-opacity));"></p>
                        <p class="sm-leading-32" style="font-weight: 600; font-size: 20px; margin: 0 0 16px; --text-opacity: 1; color: #263238; color: rgba(38, 50, 56, var(--text-opacity));">
                          {$lang->get('ThanksMail_1')} 👋
                        </p>
                        <p style="margin: 0 0 24px;">
                          {$lang->get('verifyMail')},
                          {$lang->get('expireMail_1')} {$expire} {$lang->get('expireMail_2')}.
                        </p>
                        <p style="margin: 0 0 24px;">
                          {$lang->get('ignoreMail')}.
                        </p>
                        <table style="font-family: 'Montserrat',Arial,sans-serif;" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                            <td style="mso-padding-alt: 16px 24px; --bg-opacity: 1; background-color: {$Config['app_color']}; background-color: {$Config['app_color']}; border-radius: 4px; font-family: Montserrat, -apple-system, 'Segoe UI', sans-serif;" bgcolor="rgba(115, 103, 240, var(--bg-opacity))">
                              <a href="{$code}" style="display: block; font-weight: 600; font-size: 14px; line-height: 100%; padding: 16px 24px; --text-opacity: 1; color: #ffffff; color: {$Config['app_color']}; text-decoration: none;">{$lang->get('VNow')} &rarr;</a>
                            </td>
                          </tr>
                        </table>
                        <table style="font-family: 'Montserrat',Arial,sans-serif; width: 100%;" width="100%" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                            <td style="font-family: 'Montserrat',Arial,sans-serif; padding-top: 32px; padding-bottom: 32px;">
                              <div style="--bg-opacity: 1; background-color: #eceff1; background-color: rgba(236, 239, 241, var(--bg-opacity)); height: 1px; line-height: 1px;">&zwnj;</div>
                            </td>
                          </tr>
                        </table>
                        <p style="margin: 0 0 16px;">{$lang->get('ThanksMail_2')}, <br><b>{$Config['appName']|upper}</b></p>
                      </td>
                    </tr>
                    <tr>
                      <td style="font-family: 'Montserrat',Arial,sans-serif; height: 20px;" height="20"></td>
                    </tr>
                    <tr>
                      <td style="font-family: 'Montserrat',Arial,sans-serif; height: 16px;" height="16"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </div>
  </body>

</html>