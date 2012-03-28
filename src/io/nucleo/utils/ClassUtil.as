package io.nucleo.utils {

    public class ClassUtil {

        /**
         * Helper to create a class with a list of arguments
         *
         * @param classDefinition           The class definition used to create the instance.
         * @param arguments                 The arguments used when creating an instance from the class definition.
         * @return                          The instance of the the class definition.
         */
        public static function createInstance(classDefinition:Class,
                                              arguments:Array = null):* {
            if (arguments) {
                switch (arguments.length) {
                    case 0:
                        return new classDefinition();
                    case 1:
                        return new classDefinition(arguments[0]);
                    case 2:
                        return new classDefinition(arguments[0], arguments[1]);
                    case 3:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2]);
                    case 4:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2], arguments[3]);
                    case 5:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2], arguments[3],
                                                   arguments[4]);
                    case 6:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2], arguments[3],
                                                   arguments[4], arguments[5]);
                    case 7:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2], arguments[3],
                                                   arguments[4], arguments[5],
                                                   arguments[6]);
                    case 8:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2], arguments[3],
                                                   arguments[4], arguments[5],
                                                   arguments[6], arguments[7]);
                    case 9:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2], arguments[3],
                                                   arguments[4], arguments[5],
                                                   arguments[6], arguments[7],
                                                   arguments[8]);
                    case 10:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2], arguments[3],
                                                   arguments[4], arguments[5],
                                                   arguments[6], arguments[7],
                                                   arguments[8], arguments[9]);
                    case 11:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2], arguments[3],
                                                   arguments[4], arguments[5],
                                                   arguments[6], arguments[7],
                                                   arguments[8], arguments[9],
                                                   arguments[10]);
                    case 12:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2], arguments[3],
                                                   arguments[4], arguments[5],
                                                   arguments[6], arguments[7],
                                                   arguments[8], arguments[9],
                                                   arguments[10], arguments[11]);
                    case 13:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2], arguments[3],
                                                   arguments[4], arguments[5],
                                                   arguments[6], arguments[7],
                                                   arguments[8], arguments[9],
                                                   arguments[10], arguments[11],
                                                   arguments[12]);
                        break;
                    case 14:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2], arguments[3],
                                                   arguments[4], arguments[5],
                                                   arguments[6], arguments[7],
                                                   arguments[8], arguments[9],
                                                   arguments[10], arguments[11],
                                                   arguments[12], arguments[13]);
                    case 15:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2], arguments[3],
                                                   arguments[4], arguments[5],
                                                   arguments[6], arguments[7],
                                                   arguments[8], arguments[9],
                                                   arguments[10], arguments[11],
                                                   arguments[12], arguments[13],
                                                   arguments[14]);
                    case 16:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2], arguments[3],
                                                   arguments[4], arguments[5],
                                                   arguments[6], arguments[7],
                                                   arguments[8], arguments[9],
                                                   arguments[10], arguments[11],
                                                   arguments[12], arguments[13],
                                                   arguments[14], arguments[15]);
                        break;
                    case 17:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2], arguments[3],
                                                   arguments[4], arguments[5],
                                                   arguments[6], arguments[7],
                                                   arguments[8], arguments[9],
                                                   arguments[10], arguments[11],
                                                   arguments[12], arguments[13],
                                                   arguments[14], arguments[15],
                                                   arguments[16]);
                    case 18:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2], arguments[3],
                                                   arguments[4], arguments[5],
                                                   arguments[6], arguments[7],
                                                   arguments[8], arguments[9],
                                                   arguments[10], arguments[11],
                                                   arguments[12], arguments[13],
                                                   arguments[14], arguments[15],
                                                   arguments[16], arguments[17]);
                    case 19:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2], arguments[3],
                                                   arguments[4], arguments[5],
                                                   arguments[6], arguments[7],
                                                   arguments[8], arguments[9],
                                                   arguments[10], arguments[11],
                                                   arguments[12], arguments[13],
                                                   arguments[14], arguments[15],
                                                   arguments[16], arguments[17],
                                                   arguments[18]);
                    case 20:
                        return new classDefinition(arguments[0], arguments[1],
                                                   arguments[2], arguments[3],
                                                   arguments[4], arguments[5],
                                                   arguments[6], arguments[7],
                                                   arguments[8], arguments[9],
                                                   arguments[10], arguments[11],
                                                   arguments[12], arguments[13],
                                                   arguments[14], arguments[15],
                                                   arguments[16], arguments[17],
                                                   arguments[18], arguments[19]);
                    default:
                        throw new Error("Using more then 20 arguments is not supported.");
                        break;
                }
            } else {
                return new classDefinition();
            }
        }

    }
}
