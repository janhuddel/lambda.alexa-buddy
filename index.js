const axios = require("axios");

const GATEWAY = process.env.GATEWAY;

exports.lambdaHandler = async (request, context) => {
  try {
    const response = await axios.post(`${GATEWAY}/api/v1/alexa-request`, {
      request: request,
      context: context,
    });

    return response.data;
  } catch (err) {
    console.error(err.message);

    return {
      event: {
        header: {
          namespace: "Alexa",
          name: "ErrorResponse",
          messageId: request.directive.header.messageId,
          payloadVersion: "3",
        },
        payload: {
          type: "BRIDGE_UNREACHABLE",
          message: err.message,
        },
      },
    };
  }
};
