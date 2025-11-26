function basicAuth(req, res, next) {
  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith('Basic ')) {
    res.setHeader('WWW-Authenticate', 'Basic realm="Secure Area"');
    return res.status(401).send('Authentication required');
  }

  const base64Credentials = authHeader.split(' ')[1];
  const credentials = Buffer.from(base64Credentials, 'base64').toString('ascii');
  const [username, password] = credentials.split(':');

  console.log('Basic Auth attempt with username:', username);
  console.log('Basic Auth attempt with password:', password);
  console.log('Expected username:', process.env.BASIC_AUTH_USER);
  console.log('Expected password:', process.env.BASIC_AUTH_PASS);

  if (
    username === process.env.BASIC_AUTH_USER &&
    password === process.env.BASIC_AUTH_PASS
  ) {
    return next();
  }

  return res.status(401).send('Invalid credentials');
}

module.exports = basicAuth;
