import { NativeModules } from 'react-native';

const trimVideo = async (sourcePath, startTime, endTime) => {
  return new Promise((resolve, reject) => {
    NativeModules.VideoTrimmer.trimVideo(
      sourcePath,
      startTime,
      endTime,
      (error, outputPath) => {
        if (error) {
          reject(error);
        } else {
          resolve(outputPath);
        }
      }
    );
  });
};

export { trimVideo };
