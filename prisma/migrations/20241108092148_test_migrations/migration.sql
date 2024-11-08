-- CreateEnum
CREATE TYPE "StatusKelas" AS ENUM ('ACTIVE', 'END');

-- CreateEnum
CREATE TYPE "StatusUjian" AS ENUM ('DRAFT', 'ACTIVE', 'END');

-- CreateTable
CREATE TABLE "Guru" (
    "id" UUID NOT NULL,
    "username" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,

    CONSTRAINT "Guru_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Murid" (
    "id" UUID NOT NULL,
    "username" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,

    CONSTRAINT "Murid_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Kelas" (
    "id" UUID NOT NULL,
    "classCode" TEXT NOT NULL,
    "className" TEXT NOT NULL,
    "grade" TEXT NOT NULL,
    "tahunAjaran" TEXT NOT NULL,

    CONSTRAINT "Kelas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KelasAjar" (
    "id" UUID NOT NULL,
    "idKelas" UUID NOT NULL,
    "idGuru" UUID NOT NULL,
    "EducationYear" TEXT NOT NULL,
    "status" "StatusKelas" NOT NULL,

    CONSTRAINT "KelasAjar_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PengambilanKelas" (
    "id" UUID NOT NULL,
    "idKelas" UUID NOT NULL,
    "idMurid" UUID NOT NULL,

    CONSTRAINT "PengambilanKelas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ujian" (
    "id" UUID NOT NULL,
    "idSesiPercakapan" TEXT NOT NULL,
    "idKelas" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "status" "StatusUjian" NOT NULL,

    CONSTRAINT "Ujian_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UjianAttempt" (
    "id" UUID NOT NULL,
    "idUjian" UUID NOT NULL,
    "idMurid" UUID NOT NULL,
    "score" DOUBLE PRECISION NOT NULL,
    "attemptCount" INTEGER NOT NULL,
    "waktuAttempt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UjianAttempt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SesiPercakapanChatGPT" (
    "id" UUID NOT NULL,
    "idUjian" UUID NOT NULL,
    "configuration" JSONB NOT NULL,
    "roomChatId" TEXT NOT NULL,
    "dateCreate" TIMESTAMP(3) NOT NULL,
    "dateEdit" TIMESTAMP(3),

    CONSTRAINT "SesiPercakapanChatGPT_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Guru_username_key" ON "Guru"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Guru_email_key" ON "Guru"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Murid_username_key" ON "Murid"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Murid_email_key" ON "Murid"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Kelas_classCode_key" ON "Kelas"("classCode");

-- CreateIndex
CREATE UNIQUE INDEX "SesiPercakapanChatGPT_idUjian_key" ON "SesiPercakapanChatGPT"("idUjian");

-- AddForeignKey
ALTER TABLE "KelasAjar" ADD CONSTRAINT "KelasAjar_idKelas_fkey" FOREIGN KEY ("idKelas") REFERENCES "Kelas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "KelasAjar" ADD CONSTRAINT "KelasAjar_idGuru_fkey" FOREIGN KEY ("idGuru") REFERENCES "Guru"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PengambilanKelas" ADD CONSTRAINT "PengambilanKelas_idKelas_fkey" FOREIGN KEY ("idKelas") REFERENCES "Kelas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PengambilanKelas" ADD CONSTRAINT "PengambilanKelas_idMurid_fkey" FOREIGN KEY ("idMurid") REFERENCES "Murid"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ujian" ADD CONSTRAINT "Ujian_idKelas_fkey" FOREIGN KEY ("idKelas") REFERENCES "Kelas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UjianAttempt" ADD CONSTRAINT "UjianAttempt_idUjian_fkey" FOREIGN KEY ("idUjian") REFERENCES "Ujian"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UjianAttempt" ADD CONSTRAINT "UjianAttempt_idMurid_fkey" FOREIGN KEY ("idMurid") REFERENCES "Murid"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SesiPercakapanChatGPT" ADD CONSTRAINT "SesiPercakapanChatGPT_idUjian_fkey" FOREIGN KEY ("idUjian") REFERENCES "Ujian"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
